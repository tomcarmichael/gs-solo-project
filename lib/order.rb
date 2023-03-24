class Order
  @@total_orders = 0

  # Class method to return total_orders for testing
  def self.total_orders
    @@total_orders
  end

  def initialize(name, io) # Takes the customer's name, could expand to take address etc
    @io = io
    @name = name
    @basket = [] # will contain hashes, consider creating own class for this
    @@total_orders += 1
    @order_id = @@total_orders
  end

  def basket # user can check their basket
    @basket
  end

  def name
    @name
  end

  def order_id
    @order_id
  end

  def order_from(menu) # takes a menu object
    @io.puts "Please make your selections from the menu that follows:"
    menu = menu.dishes
    menu.each do |dish|
      @io.puts dish.name
      @io.puts "Quantity:"
      quantity = @io.gets.chomp.to_i
      @basket << {dish: dish.name, quantity: quantity, cost: (quantity * dish.price) } if quantity > 0
    end
  end

  def add(dish, quantity) # Dish object, integer
    @basket << {dish: dish.name, quantity: quantity, cost: (quantity * dish.price) }
  end

  def remove(dish, quantity) # Dish object, integer
    # Fail if no hash in the basket array contains dish.name
    fail "You don't have that dish in your basket" if @basket.all? { |item| item[:dish] != dish.name }  
    @basket.each do |item|
      if item[:dish] == dish.name # If the name of dish provided is in the item hash
        item[:quantity] -= quantity
        item[:cost] -= (dish.price * quantity)
      end
      # Remove item hash from basket if quantity has gone to zero or less
      if item[:quantity] <= 0
        @basket.delete(item)
      end
    end
  end
end
