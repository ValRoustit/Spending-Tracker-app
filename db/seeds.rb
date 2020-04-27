require_relative('../models/tag')
require_relative('../models/merchant')
require_relative('../models/transaction')

# Transaction.delete_all()
# Merchant.delete_all()
# Tag.delete_all()

tag0 = Tag.new({'name' => ''})
tag0.save()
merchant0 = Merchant.new({'name' => ''})
merchant0.save()