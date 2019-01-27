require_relative( 'models/customer' )
require_relative( 'models/film' )
require_relative( 'models/ticket' )

require('pry')

Customer.delete_all()
Film.delete_all()
Ticket.delete_all()

customer1 = Customer.new ({ 'name' => 'Kim', 'funds' => '10'})
customer1.save()
customer2 = Customer.new ({ 'name' => 'Ken', 'funds' => '40'})
customer2.save()
customer3 = Customer.new ({ 'name' => 'Abi', 'funds' => '20'})
customer3.save()


film1 = Film.new ({'title' => 'Batman Begins', 'cost' => '5'})
film1.save()
film2 = Film.new ({'title' => 'The Dark Knight', 'cost' => '6'})
film2.save()
film3 = Film.new ({'title' => 'The Dark Knight Rises', 'cost' => '7'})
film3.save()


ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
ticket1.save()
ticket2 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film1.id})
ticket2.save()
ticket3 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film3.id})
ticket3.save()
ticket4 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film2.id})
ticket4.save()
ticket5 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film2.id})
ticket5.save()
ticket6 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film2.id})
ticket6.save()


# ticket6.delete()
# film3.delete()
# customer3.delete()

customer1.name = 'Kimberley'
customer1.update()

film1.cost ='4'
film1.update()

ticket5.film_id = film1.id
ticket5.update()


binding.pry
nil
