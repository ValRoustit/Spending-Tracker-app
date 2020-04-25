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

# new tag

# new merchant

# new transaction

# show

# create

# edit

# update

# delete