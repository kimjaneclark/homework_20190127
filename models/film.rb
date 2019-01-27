require_relative("../db/sql_runner.rb")

class Film

  attr_reader :id
  attr_accessor :title, :cost

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @cost = options['cost']
  end

  def save()
    sql = "INSERT INTO films
    (
      title,
      cost
      )
      VALUES
      ($1, $2)
      RETURNING id"
      values = [@title, @cost]
      film = SqlRunner.run(sql, values).first
      @id = film['id'].to_i
    end

    def self.delete_all()
      sql = "DELETE FROM films"
      SqlRunner.run(sql)
    end

    def delete()
      sql = "DELETE FROM films WHERE id = $1"
      values = [@id]
      SqlRunner.run(sql, values)
    end


    def self.all()
    sql = "SELECT * FROM films"
    films = SqlRunner.run(sql)
    result = films.map { |film| Film.new(film) }
    return result
  end

  def self.find(id)
    sql = "SELECT * FROM films WHERE ID = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    film = Film.new(result.first)
    return film
  end

  def update()
    sql = "UPDATE films SET (
    title,
    cost
    ) = ($1, $2) WHERE ID = $3"
    values = [@title, @cost, @id]
    SqlRunner.run(sql, values)
  end

  def customers()
    sql = "SELECT customers.*
    FROM customers
    INNER JOIN tickets
    ON tickets.customer_id = customers.id
    where film_id = $1
    ORDER BY customers.name"
    values =[@id]
    customer_data = SqlRunner.run(sql, values)
    return customer_data.map {|customer| Customer.new(customer)}
  end




end
