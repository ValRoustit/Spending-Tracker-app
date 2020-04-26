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
    erb(:show_merchants)
end

# show transaction_id
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

# new merchant

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

# edit tags
post '/spending-tracker/my-tags' do
    tag = Tag.new(params)
    tag.save if params[:new] == "New"
    tag.update if params[:update] == "Update"
    tag.delete if params[:delete] == "Delete"
    redirect to '/spending-tracker/my-tags'
end