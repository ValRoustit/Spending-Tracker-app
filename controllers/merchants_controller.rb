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

# new merchant