require_relative('../db/sql_runner')

class Transaction
    attr_reader :id
    attr_accessor :name, :amount, :merchant_id, :tag_id

    def initialize( options )
        @id = options['id'].to_i if options['id']
        @name = options['name']
        @amount = options['amount']
        @merchant_id = options['merchant_id'].to_i
        @tag_id = options['tag_id'].to_i
    end

    def save()
        sql = "INSERT INTO transactions (name, amount, merchant_id, tag_id) VALUES ($1, $2, $3, $4) RETURNING id"
        values = [@name, @amount, @merchant_id, @tag_id]
        transaction = SqlRunner.run(sql, values)[0]
        @id = transaction['id'].to_i
    end

    def self.find(id)
        sql = "SELECT * FROM transactions WHERE id = $1"
        values = [id]
        result = SqlRunner.run(sql, values).first
        transaction = Transaction.new(result)
        return transaction
    end

    def update()
        sql = "UPDATE transactions SET 
        (name, amount, merchant_id, tag_id)
         = 
        ($1, $2, $3, $4) WHERE id = $5"
        values = [@name, @amount, @merchant_id, @tag_id, @id]
        SqlRunner.run(sql, values)
    end


    def self.all()
        sql = "SELECT * FROM transactions"
        transaction_data = SqlRunner.run(sql)
        return Transaction.map_items(transaction_data)
    end

    def self.all_by_tag_id(tag_id)
        sql = "SELECT * FROM transactions WHERE tag_id = $1"
        values = [tag_id]
        transaction_data = SqlRunner.run(sql, values)
        return Transaction.map_items(transaction_data)
    end

    # def self.all()
    #     sql = "SELECT * FROM transactions"
    #     transaction_data = SqlRunner.run(sql)
    #     return Transaction.map_items(transaction_data)
    # end

    def tag()
        return [] if (@tag_id == 0)
        tag = Tag.find(@tag_id)
        return tag
    end

    def merchant()
        return [] if (@merchant_id == 0)
        merchant = Merchant.find(@merchant_id)
        return merchant
    end

    def delete()
        sql = "DELETE FROM transactions WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql, values)
    end

    def self.delete_all()
        sql = "DELETE FROM transactions"
        SqlRunner.run(sql)
    end

    def self.map_items(transaction_data)
        return transaction_data.map { |transaction| Transaction.new(transaction) }
    end
end