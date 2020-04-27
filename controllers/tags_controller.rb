require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/tag')
require_relative('../models/merchant')
require_relative('../models/transaction')
also_reload('../models/*')

# show tags
get '/spending-tracker/my-tags' do
    @tags = Tag.all
    erb(:show_tags)
end

get '/spending-tracker/my-tags/:id' do
    @tags = Tag.all
    @transaction = Transaction.find(params[:id])
    erb(:show_transaction_data)
end

#----------------------------------------------------------------

# create tag
post '/spending-tracker/my-tags' do
    Tag.new(params).save
    redirect to '/spending-tracker/my-tags'
end

# edit tag
post '/spending-tracker/my-tags/:id' do
    tag = Tag.new(params)
    tag.update if params[:update] == "Update"
    tag.delete if params[:delete] == "Delete"
    redirect to '/spending-tracker/my-tags'
end