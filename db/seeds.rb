require_relative('../models/tag')
require_relative('../models/merchant')
require_relative('../models/budget')
require_relative('../models/transaction')
require('pry')

merchant1 = Merchant.new({'name' => 'Amazon'})
merchant1.save()
tag1 = Tag.new({'name' => 'clothes'})
tag1.save()
budget1 = Budget.new({'name' => 'test', 'amount' => '233', 'alert_limit' => '25'})
budget1.save()

transaction1 = Transaction.new({
    'name'=>'shoes',
    'amount'=>100,
    'merchant_id'=>merchant1.id,
    'tag_id'=>tag1.id,
    'budget_id'=>budget1.id,
    'date'=>'2020-04-28'})
transaction1.save()

binding.pry
nil