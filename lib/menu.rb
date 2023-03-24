class Menu
  def initialize()
    @dishes = [] # Takes an array of dish objects
  end

  def add(*dishes) # Can take one or more dish objects, which are always passed in inside an array
    fail "You didn't provide any dishes to add" if dishes.empty?
    dishes.each do | dish| 
      fail "Dish is already on the menu" if @dishes.include?(dish)
      @dishes << dish
    end
  end

  def remove(dish) # Takes a dish objec
    fail "Dish is not on the menu" if !@dishes.include?(dish)
    @dishes.delete(dish)
  end

  def read
    @dishes.map { |dish| "#{dish.name}: £#{dish.price}" }
  end

  def dishes
    @dishes
  end
end