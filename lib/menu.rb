class Menu
  def initialize()
    @dishes = [] # Takes an array of dish objects
  end

  def add(dish) # Takes a dish object, optionally expand with optional arguments so multiple dishes can be added
    fail "Dish is already on the menu" if @dishes.include?(dish)
    @dishes << dish
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