require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/transaction')
require_relative('../models/budget')
also_reload('../models/*')

# show budgets
get '/spending-tracker/my-budgets' do
    @budgets = Budget.all
    erb(:"budgets/show_budgets")
end

# new budget
get '/spending-tracker/my-budgets/new' do
    erb(:"budgets/new_budget")
end

# show budget data
get '/spending-tracker/my-budgets/:id' do
    @budget = Budget.find(params[:id])
    @transactions = @budget.transactions
    erb(:"budgets/show_budget_data")
end



#----------------------------------------------------------------

# create budget
post '/spending-tracker/my-budgets/new' do
    Budget.new(params).save
    redirect to '/spending-tracker/my-budgets'
end

# edit budget
post '/spending-tracker/my-budgets/:id' do
    budget = Budget.new(params)
    budget.update if params[:update] == "Update"
    budget.delete if params[:delete] == "Delete"
    redirect to '/spending-tracker/my-budgets'
end