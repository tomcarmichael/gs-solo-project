require "confirmation"

describe Confirmation do
  it "Returns receipt and order info" do
    order = double(:order, basket:[{dish: "Pizza", quantity: 1, cost: 10}])
    order_time = Time.now
    allow(order).to receive(:order_time).and_return order_time
    allow(order).to receive(:order_id).and_return 100
    allow(order).to receive(:name).and_return "Joni"

    receipt_class = double(:Receipt)
    receipt_instance = double(:receipt)
    allow(receipt_class).to receive(:new).with(order.basket).and_return(receipt_instance)
    allow(receipt_instance).to receive(:print).and_return ["Pizza x1 => £10", "Grand total: £10"]

    confirmation = Confirmation.new(order, receipt_class)

    expect(confirmation.receipt).to eq ["Pizza x1 => £10", "Grand total: £10", "Order ID: 100. Order placed at: #{order_time.strftime("%H:%M")} by Joni"]
  end
end