class Receipt
  def initialize(basket) # Takes an array of hashes
    @basket = basket
  end

  def print
    @basket.map do |item|
      "#{item[:dish]} x#{item[:quantity]} => £#{item[:cost]}"
    end.append("Grand total: £#{calculate_total}")
  end

  private

  def calculate_total
    @basket.inject do |item, n|
      item[:cost] + n
    end
  end
end