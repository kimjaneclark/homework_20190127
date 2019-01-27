require_relative ("../db/sql_runner.rb")

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds']
  end

  def save()
    sql = "INSERT INTO customers
    (
      name,
      funds

      )
      VALUES
      ($1, $2)
      RETURNING id"
      values = [@name, @funds]
      customer = SqlRunner.run(sql, values).first
      @id = customer['id'].to_i
    end

    def self.delete_all()
      sql = "DELETE FROM customers"
      SqlRunner.run(sql)
    end


    def self.all()
      sql = "SELECT * FROM customers"
      customers = SqlRunner.run(sql)
      result = customers.map { |customer| Customer.new( customer ) }
      return result
    end

    def self.find(id)
      sql = "SELECT * FROM customers WHERE ID = $1"
      values = [id]
      result = SqlRunner.run(sql, values)
      customer = Customer.new(result.first)
      return customer
    end

    def delete()
      sql = "DELETE FROM customers WHERE id = $1"
      values = [@id]
      SqlRunner.run(sql, values)
    end

    def update()
      sql = "UPDATE customers SET (
      name,
      funds
      ) = ($1, $2) WHERE ID = $3"
      values = [@name, @funds, @id]
      SqlRunner.run(sql, values)
    end

    def films()
      sql = "SELECT films.*
      FROM films
      INNER JOIN tickets
      ON tickets.film_id = films.id
      where customer_id = $1
      ORDER BY films.title"
      values =[@id]
      film_data = SqlRunner.run(sql, values)
      return film_data.map {|film| Film.new(film)}
    end






end
