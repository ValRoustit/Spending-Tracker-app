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




    def self.map_items(merchant_data)
        return merchant_data.map { |merchant| Merchant.new(merchant) }
    end
end