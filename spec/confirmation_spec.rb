require "confirmation"

describe Confirmation do
  let(:order) { double(:order, order_id: 100, name: "Joni", basket:[{dish: "Pizza", quantity: 1, cost: 10}]) }
  let(:messaging_module) { double(:messaging_module, new: double(:client, messages: double(:messages, create: double(:message, sid: "test_sid")))) }
  let(:receipt_class) { double(:receipt_class, new: double(:receipt, print: ["Pizza x1 => £10", "Grand total: £10"])) }
  let(:confirmation) { Confirmation.new(order, receipt_class, messaging_module, Kernel) }

  before do
    allow(Time).to receive(:now).and_return(Time.utc(2023, 4, 7, 10, 0, 0))
    allow(ENV).to receive(:[]).with('TWILIO_ACCOUNT_SID').and_return("TWILIO_ACCOUNT_SID")
    allow(ENV).to receive(:[]).with('TWILIO_AUTH_TOKEN').and_return("TWILIO_AUTH_TOKEN")
  end

  it "Returns receipt and order info" do
    # order = double(:order, basket:[{dish: "Pizza", quantity: 1, cost: 10}])
    # order_time = Time.now
    # allow(order).to receive(:order_time).and_return order_time
    # allow(order).to receive(:order_id).and_return 100
    # allow(order).to receive(:name).and_return "Joni"

    # receipt_class = double(:Receipt)
    # receipt_instance = double(:receipt)
    # allow(receipt_class).to receive(:new).with(order.basket).and_return(receipt_instance)
    # allow(receipt_instance).to receive(:print).and_return ["Pizza x1 => £10", "Grand total: £10"]

    # confirmation = Confirmation.new(order, receipt_class)
    # expect(confirmation.receipt).to eq ["Pizza x1 => £10", "Grand total: £10", "Order ID: 100. Order placed at: #{order_time.strftime("%H:%M")} by Joni"]
    expect(confirmation.receipt).to eq ["Pizza x1 => £10", "Grand total: £10", "Order ID: 100. Order placed at: 10:00 by Joni"]
  end


  describe "#notify" do 
    xit 'sends a notification message' do
      expect(messaging_module.new).to receive(:messages).and_return(double("Message", create: double("Response", sid: "1234")))
      confirmation.notify
    end
  end
end