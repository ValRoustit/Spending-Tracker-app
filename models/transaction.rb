require_relative('../db/sql_runner')

class Transaction
    attr_reader :id
    attr_accessor :name, :amount, :merchant_id, :tag_id, :budget_id, :date

    def initialize( options )
        @id = options['id'].to_i if options['id']
        @name = options['name']
        @amount = options['amount'].to_f
        @merchant_id = options['merchant_id'].to_i
        @tag_id = options['tag_id'].to_i
        @budget_id = options['budget_id'].to_i
        @date = options['date'].to_s
    end

    def save()
        sql = "INSERT INTO transactions 
        (name, amount, merchant_id, tag_id, budget_id, date)
        VALUES
        ($1, $2, $3, $4, $5, $6) RETURNING id"
        values = [@name, @amount, @merchant_id, @tag_id, @budget_id, @date]
        transaction = SqlRunner.run(sql, values)[0]
        @id = transaction['id'].to_i
    end

    def self.find(id)
        sql = "SELECT * FROM transactions WHERE id = $1"
        values = [id]
        result = SqlRunner.run(sql, values).first
        return Transaction.new(result)
    end

    def show_date()
        sql = ""
    end

    def self.filter(params)
        merchant_id = params[:merchant_id].to_i
        budget_id = params[:budget_id].to_i
        tag_id = params[:tag_id].to_i

        transactions = Transaction.all
        transactions = transactions.find_all {|transaction| transaction.merchant_id == merchant_id} unless merchant_id == 0
        transactions = transactions.find_all {|transaction| transaction.budget_id == budget_id} unless budget_id == 0
        transactions = transactions.find_all {|transaction| transaction.tag_id == tag_id} unless tag_id == 0

        return transactions

        # sql = "SELECT * FROM transactions WHERE merchant_id = $1 AND budget_id = $2 AND tag_id = $3"
        # values = [merchant_id, budget_id, tag_id]
        # transaction_data = SqlRunner.run(sql, values)
        # return Transaction.map_items(transaction_data)
    end

    def update()
        sql = "UPDATE transactions SET 
        (name, amount, merchant_id, tag_id, budget_id, date)
         = 
        ($1, $2, $3, $4, $5, $6) WHERE id = $7"
        values = [@name, @amount, @merchant_id, @tag_id, @budget_id, @date, @id]
        SqlRunner.run(sql, values)
    end

    def self.all()
        sql = "SELECT * FROM transactions"
        transaction_data = SqlRunner.run(sql)
        return Transaction.map_items(transaction_data)
    end

    def tag()
        return Tag.find(@tag_id)
    end

    def merchant()
        return Merchant.find(@merchant_id)
    end

    def budget()
        return Budget.find(@budget_id)
    end

    def self.total()
        transactions = Transaction.all()
        return transactions.sum(0) {|transaction| transaction.amount.to_f}
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