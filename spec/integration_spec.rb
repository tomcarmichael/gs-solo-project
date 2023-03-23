require "dish"
require "menu"

describe "integration" do
  context "Menu" do
    it "prints the only dish on the menu" do
      calamari = Dish.new("Calamari", 3)
      menu = Menu.new
      menu.add(calamari)
      expect(menu.read).to eq ["Calamari: £3"]
    end
  end

  context "Order" do 
    it "allows user to order from the menu and returns their basket" do
      calamari = Dish.new("Calamari", 3)
      chips = Dish.new("Chips", 2)
      menu = Menu.new
      menu.add(calamari)
      menu.add(chips)
      io = double(:io)
      order = Order.new("Tom", io)
      expect(io).to receive(:puts).with("Please make your selections from the menu that follows:").ordered
      expect(io).to receive(:puts).with("Calamari").ordered
      expect(io).to receive(:puts).with("Quantity:").ordered
      expect(io).to receive(:gets).and_return("1").ordered
      expect(io).to receive(:puts).with("Chips").ordered
      expect(io).to receive(:puts).with("Quantity:").ordered
      expect(io).to receive(:gets).and_return("2").ordered
      order.order_from(menu)
      expect(order.basket).to eq [{dish: "Calamari", quantity: 1, cost: 3}, {dish: "Chips", quantity: 2, cost: 4}]
    end
  end

  context "Receipt" do
    it "returns a receipt for an order" do
      calamari = Dish.new("Calamari", 3)
      chips = Dish.new("Chips", 2)
      pizza = Dish.new("Pizza", 10)
      menu = Menu.new
      menu.add(calamari)
      menu.add(chips)
      menu.add(pizza)
      io = double(:io)
      order = Order.new("Tom", io)
      expect(io).to receive(:puts).with("Please make your selections from the menu that follows:").ordered
      expect(io).to receive(:puts).with("Calamari").ordered
      expect(io).to receive(:puts).with("Quantity:").ordered
      expect(io).to receive(:gets).and_return("1").ordered
      expect(io).to receive(:puts).with("Chips").ordered
      expect(io).to receive(:puts).with("Quantity:").ordered
      expect(io).to receive(:gets).and_return("2").ordered
      order.order_from(menu)
      expect(order.basket).to eq [{dish: "Calamari", quantity: 1, cost: 3}, {dish: "Chips", quantity: 2, cost: 4}] 
    end
  end     
end