require_relative('../db/sql_runner')

class Transaction
    attr_reader :id
    attr_accessor :name, :amount, :merchant_id, :tag_id

    def initialize( options )
        @id = options['id'].to_i if options['id']
        @name = options['name']
        @amount = options['amount']
        @merchant_id = options['merchant_id'].to_i
        @tag_id = options['tag_id'].to_id
    end

end