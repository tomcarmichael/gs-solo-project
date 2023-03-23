require "dish"

describe Dish do
  it "returns the name of the dish" do
    calamari = Dish.new("Calamari", 3)
    expect(calamari.name).to eq "Calamari"
  end

  it "returns the price of the dish" do
    calamari = Dish.new("Calamari", 3)
    expect(calamari.price).to eq 3
  end
end