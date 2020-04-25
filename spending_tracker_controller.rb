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

# show_transactions
get '/spending-tracker/my-spendings' do
    @transactions = Transaction.all
    erb(:show_transactions)
end

# show_tags
get '/spending-tracker/my-tags' do
    @tags = Tag.all
    erb(:show_tags)
end

# show_merchants
get '/spending-tracker/my-merchants' do
    @merchants = Merchant.all
    erb(:show_merchants)
end

# new merchant

# new transaction
get '/spending-tracker/new' do
    erb(:new_spending)
end


# create

# edit

# update

# delete