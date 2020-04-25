require_relative('models/merchant')
require_relative('models/tag')
require_relative('models/transaction')

require('pry')

Merchant.delete_all()
Tag.delete_all()

merchant1 = Merchant.new({'name' => 'Amazon'})
merchant1.save()
tag1 = Tag.new({'name' => 'clothes'})
tag1.save()

transaction1 = Transaction.new({'name'=>'shoes','amount'=>100,'merchant_id'=>merchant1.id,'tag_id'=>tag1.id})
binding.pry
nil