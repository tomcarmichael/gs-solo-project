require "order"

describe Order do
  it "returns the name of the orderer" do
    io = double(:io)
    order = Order.new("Tom", io)
    expect(order.name).to eq "Tom"
  end

  it "returns the order ID" do
    io = double(:io)
    total_orders = Order.total_orders # Returns class variable @@total_orders
    order = Order.new("Tom", io)
    expect(order.order_id).to eq (total_orders + 1)
  end

  it "allows user to order from the menu and returns their basket" do
    calamari = double(:fake_dish, name:"Calamari", price: 3)
    chips = double(:fake_dish, name:"Chips", price: 2)
    menu = double (:menu)
    allow(menu).to receive(:dishes).and_return([calamari, chips])
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

  it "adds an item to the basket" do
    calamari = double(:fake_dish, name:"Calamari", price: 3)
    chips = double(:fake_dish, name:"Chips", price: 2)
    order = Order.new("Tom", Kernel)
    order.add(calamari, 1)
    order.add(chips, 2)
    expect(order.basket).to eq [{dish: "Calamari", quantity: 1, cost: 3}, {dish: "Chips", quantity: 2, cost: 4}]
  end

context "#remove" do
    it "removes all quantities of an item from the basket without removing other items" do
      calamari = double(:fake_dish, name:"Calamari", price: 3)
      chips = double(:fake_dish, name:"Chips", price: 2)
      order = Order.new("Tom", Kernel)
      order.add(calamari, 1)
      order.add(chips, 2)
      order.remove(calamari, 1)
      order.remove(chips, 1)
      expect(order.basket).to eq [{dish: "Chips", quantity: 1, cost: 2}]
    end

    it "removes one quantity of an item from the basket" do
      calamari = double(:fake_dish, name:"Calamari", price: 3)
      chips = double(:fake_dish, name:"Chips", price: 2)
      order = Order.new("Tom", Kernel)
      order.add(chips, 2)
      order.remove(chips, 1)
      expect(order.basket).to eq [{dish: "Chips", quantity: 1, cost: 2}]
    end

    it "removes all quantities of an item from the basket" do
      calamari = double(:fake_dish, name:"Calamari", price: 3)
      chips = double(:fake_dish, name:"Chips", price: 2)
      order = Order.new("Tom", Kernel)
      order.add(chips, 2)
      order.remove(chips, 2)
      expect(order.basket).to eq []
    end

    it "fails if you try to remove a dish not in the basket" do
      calamari = double(:fake_dish, name:"Calamari", price: 3)
      chips = double(:fake_dish, name:"Chips", price: 2)
      order = Order.new("Tom", Kernel)
      order.add(chips, 2)
      expect { order.remove(calamari, 1) }.to raise_error "You don't have that dish in your basket"
    end
  end
    
end