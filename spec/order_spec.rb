require "order"

describe Order do
  it "returns the name of the orderer" do
    io = double(:io)
    order = Order.new("Tom", io)
    expect(order.name).to eq "Tom"
  end

  it "returns the order ID" do
    io = double(:io)
    total_orders = Order.total_orders
    order = Order.new("Tom", io)
    expect(order.order_id).to eq (total_orders + 1)
  end


  xit "allows user to order from the menu" do
    #calamari = double(:fake_dish, name: "Calamari", price: 3)
    #chips = double(:fake_dish, name:"Chips", price: 2)
    menu = double(:fake_menu)
    #menu.add(calamari)
    #menu.add(chips)
    
    allow(menu).to receive(:read).and_return(["Calamari: £3", "Chips: £2"])
    io = double(:io)
    expect(io).to receive(:puts).with("Please make your selections from the menu that follows:")
    expect(io).to receive(:puts).with("Calamari")
    expect(io).to receive(:puts).with("Quantity:")
    expect(io).to receive(:gets).and_return("1")
    order = Order.new("Tom", io)
    order.order_from(menu)
    # need to test gets and puts here
  end
end