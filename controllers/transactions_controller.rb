require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/tag')
require_relative('../models/merchant')
require_relative('../models/transaction')
require_relative('../models/budget')
also_reload('../models/*')

# show transactions
get '/spending-tracker/my-spendings' do
    @merchants = Merchant.all
    @budgets = Budget.all
    @tags = Tag.all

    @transactions = Transaction.all
    @total = Transaction.total
    erb(:"transactions/show_transactions")
end

get '/spending-tracker/my-spendings/:id' do
    @merchants = Merchant.all
    @tags = Tag.all
    @budgets = Budget.all
    @transaction = Transaction.find(params[:id])
    erb(:"transactions/show_transaction_data")
end

# new transaction
get '/spending-tracker/new' do
    @merchants = Merchant.all
    @tags = Tag.all
    @budgets = Budget.all
    erb(:"transactions/new_transaction")
end

#----------------------------------------------------------------

# filter
post '/spending-tracker/my-spendings' do
    @merchants = Merchant.all
    @budgets = Budget.all
    @tags = Tag.all

    @transactions = Transaction.filter(params)
    @total = @transactions.sum(0) {|transaction| transaction.amount.to_f}
    erb(:"transactions/show_transactions")
end

# create transaction
post '/spending-tracker/new' do
    Transaction.new(params).save
    redirect to '/spending-tracker/my-spendings'
end

# edit transaction
post '/spending-tracker/my-spendings/:id' do
    p params
    transaction = Transaction.new(params)
    p transaction
    transaction.update if params[:update] == "Update"
    transaction.delete if params[:delete] == "Delete"
    redirect to '/spending-tracker/my-spendings'
end