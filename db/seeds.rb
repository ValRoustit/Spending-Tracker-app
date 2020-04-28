require_relative('../models/tag')
require_relative('../models/merchant')
require_relative('../models/budget')
require_relative('../models/transaction')
require('pry')

# Transaction.delete_all()
# Merchant.delete_all()
# Tag.delete_all()
# Budget.delete_all()

tag0 = Tag.new({'name' => ''})
tag0.save()
merchant0 = Merchant.new({'name' => ''})
merchant0.save()
budget0 = Budget.new({'name' => '', 'amount' => nil, 'alert_limit' => nil})
budget0.save()

merchant1 = Merchant.new({'name' => 'Amazon'})
merchant1.save()
tag1 = Tag.new({'name' => 'clothes'})
tag1.save()

transaction1 = Transaction.new({
    'name'=>'shoes',
    'amount'=>100,
    'merchant_id'=>merchant1.id,
    'tag_id'=>tag1.id,
    'budget_id'=>budget0.id,
    'date'=>'2020-04-28'})
transaction1.save()
# transaction1 = Transaction.new({'name'=>'shoes','amount'=>300,'merchant_id'=>merchant1.id,'tag_id'=>tag1.id, 'budget_id'=>budget0.id, 'date'=>'28.04.2020'})
# transaction1.save()
# transaction1 = Transaction.new({'name'=>'shoes','amount'=>200,'merchant_id'=>merchant1.id,'tag_id'=>tag1.id, 'budget_id'=>budget0.id, 'date'=>'28.04.2020'})
# transaction1.save()

binding.pry
nil