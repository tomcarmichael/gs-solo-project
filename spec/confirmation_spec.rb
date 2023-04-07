require "confirmation"

describe Confirmation do
  let(:order) { double(:order, order_id: 100, name: "Joni", basket:[{dish: "Pizza", quantity: 1, cost: 10}]) }
  let(:messaging_module) { double(:messaging_module) }
  let(:receipt_class) { double(:receipt_class, new: double(:receipt, print: ["Pizza x1 => £10", "Grand total: £10"])) }
  let(:confirmation) { Confirmation.new(order, receipt_class, messaging_module, Kernel) }

  before do
    allow(Time).to receive(:now).and_return(Time.utc(2023, 4, 7, 10, 0, 0))
    allow(ENV).to receive(:[]).with('TWILIO_ACCOUNT_SID').and_return("TWILIO_ACCOUNT_SID")
    allow(ENV).to receive(:[]).with('TWILIO_AUTH_TOKEN').and_return("TWILIO_AUTH_TOKEN")
  end

  it "Returns receipt and order info" do
    expect(confirmation.receipt).to eq ["Pizza x1 => £10", "Grand total: £10", "Order ID: 100. Order placed at: 10:00 by Joni"]
  end

  describe "#notify" do 
    it 'sends a notification message' do
      # Should I test to expect that ENV will receive [] and return API key details?
      @client = double(:client)
      expect(messaging_module).to receive(:new).and_return(@client)
      messages_object = double(:messages_object)
      expect(@client).to receive(:messages).and_return(messages_object)
      expect(messages_object).to receive(:create).with(
        body: "Hello Joni! Your order has been received and will be delivered by 11:00. Order ID: #{confirmation.order_id} ",
        from: '+14752646904',
        to: '+447917855547'
      ).and_return(double(:message, sid: "test_message_SID"))
      expect(Kernel).to receive(:puts).with("test_message_SID")
      confirmation.notify
    end
  end
end