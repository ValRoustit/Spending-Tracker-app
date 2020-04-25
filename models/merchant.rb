require_relative('../db/sql_runner')

class Merchant
    attr_reader :id
    attr_accessor :name

    def initialize( options )
        @id = options['id'].to_i if options['id']
        @name = options['name']
    end

    def save()
        sql = "INSERT INTO merchants (name) VALUES ($1) RETURNING id"
        values = [@name]
        result = SqlRunner.run(sql, values)
        id = result.first["id"]
        @id = id.to_i
    end

    def self.find(id)
        sql = "SELECT * FROM merchants WHERE id = $1"
        values = [id]
        result = SqlRunner.run(sql, values).first
        merchant = Merchant.new(result)
        return merchant
    end

    def update()
        sql = "UPDATE merchants SET (name) = ($1) WHERE id = $2"
        values = [@name, @id]
        SqlRunner.run(sql, values)
    end

    def self.all()
        sql = "SELECT * FROM merchants"
        merchant_data = SqlRunner.run(sql)
        merchants = map_items(merchant_data)
        return merchants
    end

    def delete()
        sql = "DELETE FROM merchants WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql, values)
    end

    def self.map_items(merchant_data)
        return merchant_data.map { |merchant| Merchant.new(merchant) }
    end
end