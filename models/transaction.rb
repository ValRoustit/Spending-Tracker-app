require_relative('../db/sql_runner')

class Transaction
    attr_reader :id
    attr_accessor :name, :amount, :merchant_id, :tag_id, :budget_id, :date

    def initialize( options )
        @id = options['id'].to_i if options['id']
        @name = options['name']
        @amount = options['amount'].to_f
        @merchant_id = options['merchant_id']
        @tag_id = options['tag_id']
        @budget_id = options['budget_id']
        @date = options['date'].to_s
    end

    def save()
        @merchant_id = id_exist(@merchant_id)
        @budget_id = id_exist(@budget_id)
        @tag_id = id_exist(@tag_id)

        sql = "INSERT INTO transactions 
        (name, amount, merchant_id, tag_id, budget_id, date)
        VALUES
        ($1, $2, $3, $4, $5, $6) RETURNING id"
        values = [@name, @amount, @merchant_id, @tag_id, @budget_id, @date]
        transaction = SqlRunner.run(sql, values)[0]
        @id = transaction['id'].to_i
    end

    def id_exist(id)
        return nil if id == 0
    end

    def self.find(id)
        sql = "SELECT * FROM transactions WHERE id = $1"
        values = [id]
        result = SqlRunner.run(sql, values).first
        return Transaction.new(result)
    end

    def show_date()
        sql = "SELECT TO_CHAR(date, 'dd/mm/yyyy') as datef FROM transactions WHERE id = $1"
        values = [@id]
        result = SqlRunner.run(sql, values).first['datef']
        return result
    end

    def self.filter(params)
        merchant_id = params[:merchant_id].to_i
        budget_id = params[:budget_id].to_i
        tag_id = params[:tag_id].to_i

        sql = "SELECT * FROM transactions "
        data = []
        data[0] = sql
        data[1] = false
        
        data = filter_logic(data[0], "merchant_id ", merchant_id, data[1])
        data = filter_logic(data[0], "budget_id ", budget_id, data[1])
        data = filter_logic(data[0], "tag_id ", tag_id, data[1])

        # if merchant_id != -1
        #     sql += " WHERE merchant_id = #{merchant_id}" if merchant_id != 0
        #     sql += " WHERE merchant_id = NULL" if merchant_id == 0
        # end

        result = SqlRunner.run(data[0])
        return Transaction.map_items(result)

        # transactions = Transaction.all
        # transactions = transactions.find_all {|trans| trans.merchant_id == merchant_id} unless merchant_id == 0
        # transactions = transactions.find_all {|trans| trans.budget_id == budget_id} unless budget_id == 0
        # transactions = transactions.find_all {|trans| trans.tag_id == tag_id} unless tag_id == 0

        # return transactions
    end

    def self.filter_logic(sql, string, id, bool)
        logic = "AND " if bool
        logic = "WHERE " if !bool
        if id != -1 
            sql += logic + string + "= #{id}" if id != 0
            sql += logic + string + "= NULL" if id == 0
            bool = true
        end
        return [sql, bool]
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