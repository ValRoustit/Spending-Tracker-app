require_relative('models/merchant')
require_relative('models/tag')
require_relative('models/transaction')

require('pry')

# Transaction.delete_all()
# Merchant.delete_all()
# Tag.delete_all()

merchant1 = Merchant.new({'name' => 'Amazon'})
merchant1.save()
tag1 = Tag.new({'name' => 'clothes'})
tag1.save()

transaction1 = Transaction.new({'name'=>'shoes','amount'=>100,'merchant_id'=>merchant1.id,'tag_id'=>tag1.id})
transaction1.save()
transaction1 = Transaction.new({'name'=>'shoes','amount'=>300,'merchant_id'=>merchant1.id,'tag_id'=>tag1.id})
transaction1.save()
transaction1 = Transaction.new({'name'=>'shoes','amount'=>200,'merchant_id'=>merchant1.id,'tag_id'=>tag1.id})
transaction1.save()
binding.pry
nil