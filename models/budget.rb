require_relative('../db/sql_runner')

class Budget
    attr_reader :id
    attr_accessor :name, :amount, :alert_limit

    def initialize( options )
        @id = options['id'].to_i if options['id']
        @name = options['name']
        @amount = options['amount'].to_f
        @alert_limit = options['alert_limit'].to_i
    end

    def save()
        sql = "INSERT INTO budgets 
        (name, amount, alert_limit) 
        VALUES 
        ($1, $2, $3) RETURNING id"
        values = [@name, @amount, @alert_limit]
        budget = SqlRunner.run(sql, values)[0]
        @id = budget['id'].to_i
    end

    def self.find(id)
        sql = "SELECT * FROM budgets WHERE id = $1"
        values = [id]
        result = SqlRunner.run(sql, values).first
        return Budget.new(result)
    end

    def update()
        sql = "UPDATE budgets SET name = $1 WHERE id = $2"
        values = [@name, @id]
        SqlRunner.run(sql, values)
    end

    def transactions()
        sql = "SELECT * FROM transactions WHERE budget_id = $1 ORDER BY date DESC"
        values = [@id]
        transactions_data = SqlRunner.run(sql, values)
        return Transaction.map_items(transactions_data)
    end

    def remain()
        # sql = "SELECT "
        transactions = transactions()
        spent = transactions.sum(0) {|transaction| transaction.amount.to_f}
        return @amount - spent
    end

    def alert()
        limit = (@amount * @alert_limit)/100
        remain = remain()
        status = remain - limit
        return "#e6b0c5" if remain < 0 unless @alert_limit == 0
        return "#b0e0e6" if status >= 0
        return "#e6d1b0" if status < 0
    end

    def self.all()
        sql = "SELECT * FROM budgets"
        budget_data = SqlRunner.run(sql)
        return map_items(budget_data)
    end

    def self.all_remains()
        sql = ""
    end

    def delete()
        sql = "DELETE FROM budgets WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql, values)
    end

    def self.delete_all()
        sql = "DELETE FROM budgets"
        SqlRunner.run(sql)
    end

    def self.map_items(budget_data)
        return budget_data.map { |budget| Budget.new(budget) }
    end

end