require_relative('../db/sql_runner')

class Tag
    attr_reader :id
    attr_accessor :name

    def initialize( options )
        @id = options['id'].to_i if options['id']
        @name = options['name']
    end

    def save()
        sql = "INSERT INTO tags(name) VALUES ($1) RETURNING id"
        values = [@name]
        result = SqlRunner.run(sql, values)
        id = result.first["id"]
        @id = id.to_i
    end

    def self.find(id)
        sql = "SELECT * FROM tags WHERE id = $1"
        values = [id]
        result = SqlRunner.run(sql, values).first
        return Tag.new(result)
    end

    def update()
        sql = "UPDATE tags SET name = $1 WHERE id = $2"
        values = [@name, @id]
        SqlRunner.run(sql, values)
    end

    def transactions()
        sql = "SELECT * FROM transactions WHERE tag_id = $1"
        values = [@id]
        transactions_data = SqlRunner.run(sql, values)
        return Transaction.map_items(transactions_data)
    end

    def self.all()
        sql = "SELECT * FROM tags"
        tag_data = SqlRunner.run(sql)
        return map_items(tag_data)
    end

    def delete()
        return nil if @id == 1
        transactions = self.transactions()
        transactions.each do |transaction|
            transaction.tag_id = 1
            transaction.update()
        end
        sql = "DELETE FROM tags WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql, values)
    end

    def self.delete_all()
        sql = "DELETE FROM tags"
        SqlRunner.run(sql)
    end

    def self.map_items(tag_data)
        return tag_data.map { |tag| Tag.new(tag) }
    end
end