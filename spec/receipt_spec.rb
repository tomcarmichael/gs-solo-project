require "receipt"

describe Receipt do
  it "Returns receipt" do
    basket = {dish: "Calamari", quantity: 3, cost: 9}, {dish: "Chips", quantity: 2, cost: 8}
    receipt = Receipt.new(basket)
    expect(receipt.print).to eq ["Calamari x3 => £9", "Chips x2 => £8", "Grand total: £17"]
  end
end