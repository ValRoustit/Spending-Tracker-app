require('sinatra')
require('sinatra/contrib/all')
require_relative('models/merchant')
require_relative('models/tag')
require_relative('models/transaction')
also_reload('./models/*')
require('pry')


# index
get '/spending-tracker' do 
    erb(:index)
end

# show transactions
get '/spending-tracker/my-spendings' do
    @transactions = Transaction.all
    erb(:show_transactions)
end

# show tags
get '/spending-tracker/my-tags' do
    @tags = Tag.all
    erb(:show_tags)
end

# show merchants
get '/spending-tracker/my-merchants' do
    @merchants = Merchant.all
    @merchants = Merchant.all
    @tags = Tag.all
    erb(:show_merchants)
end

# show transaction_id
get '/spending-tracker/my-spendings/:id' do
    @transation = Transaction.find(params[:id])
    @merchants = Merchant.all
    @tags = Tag.all
    erb(:show_transaction_data)
end

# new merchant

# new transaction
get '/spending-tracker/new' do
    @merchants = Merchant.all
    @tags = Tag.all
    erb(:new_spending)
end

# create
post '/spending-tracker/my-spendings' do
    p params
    Transaction.new(params).save
    redirect to '/spending-tracker/my-spendings'
end

# edit

# update

# delete