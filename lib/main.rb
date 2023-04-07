require_relative "./dish.rb"
require_relative "./menu.rb"
require_relative "./order.rb"
require_relative "./confirmation.rb"
require_relative "./receipt.rb"

calamari = Dish.new("Calamari", 3)
chips = Dish.new("Chips", 2)
pizza = Dish.new("Pizza", 10)
menu = Menu.new
menu.add(calamari)
menu.add(chips)
menu.add(pizza)
order = Order.new("Tom", Kernel)
order.order_from(menu)
puts "Basket now contains:"
puts order.basket
confirmation = Confirmation.new(order, Receipt, Twilio::REST::Client, Kernel)
puts confirmation.receipt
confirmation.notify 