require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/tag')
require_relative('../models/merchant')
require_relative('../models/transaction')
also_reload('../models/*')

# show transactions
get '/spending-tracker/my-spendings' do
    @transactions = Transaction.all
    erb(:show_transactions)
end

get '/spending-tracker/my-spendings/:id' do
    @merchants = Merchant.all
    @tags = Tag.all
    @transaction = Transaction.find(params[:id])
    erb(:show_transaction_data)
end

# new transaction
get '/spending-tracker/new' do
    @merchants = Merchant.all
    @tags = Tag.all
    erb(:new_transaction)
end

#----------------------------------------------------------------

# create transaction
post '/spending-tracker/new' do
    Transaction.new(params).save
    redirect to '/spending-tracker/my-spendings'
end

# edit transaction
post '/spending-tracker/my-spendings/:id' do
    transaction = Transaction.new(params)
    transaction.update if params[:update] == "Update"
    transaction.delete if params[:delete] == "Delete"
    redirect to '/spending-tracker/my-spendings'
end