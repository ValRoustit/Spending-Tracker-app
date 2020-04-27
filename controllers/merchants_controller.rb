require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/tag')
require_relative('../models/merchant')
require_relative('../models/transaction')
also_reload('../models/*')

# show merchants
get '/spending-tracker/my-merchants' do
    @merchants = Merchant.all
    erb(:show_merchants)
end

get '/spending-tracker/my-merchants/:id' do
    @merchant = Merchant.find(params[:id])
    @transactions = @merchant.transactions()
    erb(:show_merchant_data)
end

#----------------------------------------------------------------

# create merchant
post '/spending-tracker/my-merchants' do
    Merchant.new(params).save
    redirect to '/spending-tracker/my-merchants'
end

# edit merchant
post '/spending-tracker/my-merchants/:id' do
    merchant = Merchant.new(params)
    # merchant.update if params[:update] == "Update"
    # merchant.delete if params[:delete] == "Delete"
    # redirect to '/spending-tracker/my-merchants'
    if params[:update] == "Update"
        p merchant
        merchant.update
        redirect to "/spending-tracker/my-merchants/#{params[:id]}"
    end
    if params[:delete] == "Delete"
        merchant.delete
        redirect to '/spending-tracker/my-merchants'
    end
end