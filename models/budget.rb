require_relative('../db/sql_runner')

class Budget
    attr_reader :id
    attr_accessor :name, :amount, :alert_limit

    def initialize( options )
        @id = options['id'].to_i if options['id']
        @name = options['name']
        @amount = options['amount'].to_f
        @alert_limit = options[:alert_limit].to_i
    end

    def save()
        sql = "INSERT INTO budgets (name, amount, alert_limit) VALUES ($1, $2, $3) RETURNING id"
        values = [@name, @amount, @alert_limit]
        budget = SqlRunner.run(sql, values)[0]
        @id = budget['id'].to_i
    end



    def self.delete_all()
        sql = "DELETE FROM budgets"
        SqlRunner.run(sql)
    end

    def self.map_items(budget_data)
        return budget_data.map { |budget| Budget.new(budget) }
    end

end