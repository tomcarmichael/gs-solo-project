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
      @basket << {dish: dish.name, quantity: quantity, cost: (quantity * dish.price) }
    end
  end

  def confirm_order # Consider breaking this out into a separate class
    @order_time = Time.now
    Confirmation.new(self) # does this work???
    # bonus - ask user for confirmation of order
    # bonus - use gets for y/n
  end
end
