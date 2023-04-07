require "dish"
require "menu"
require "order"
require "confirmation"
require "receipt"

describe "Integration" do
  let(:io) { double(:io) }
  let(:order) { Order.new("Tom", io) }
  let(:calamari) { Dish.new("Calamari", 3) }  
  let(:chips) { Dish.new("Chips", 2) }
  let(:menu) { Menu.new }
  let(:messaging_module) { double("Twilio::REST::Client") }
  let(:confirmation) { Confirmation.new(order, Receipt, messaging_module, Kernel) }

  before do 
    menu.add(calamari)
    menu.add(chips)
    allow(Time).to receive(:now).and_return(Time.utc(2023, 4, 7, 10, 0, 0))
    allow(ENV).to receive(:[]).with('TWILIO_ACCOUNT_SID').and_return("TWILIO_ACCOUNT_SID")
    allow(ENV).to receive(:[]).with('TWILIO_AUTH_TOKEN').and_return("TWILIO_AUTH_TOKEN")
  end

  describe "Menu" do
    it "prints the dishes on the menu" do
      expect(menu.read).to eq ["Calamari: £3", "Chips: £2"]
    end
  end

  def prompt_user_to_order_first_dish
    expect(io).to receive(:puts).with("Please make your selections from the menu that follows:").ordered
    expect(io).to receive(:puts).with("Calamari").ordered
    expect(io).to receive(:puts).with("Quantity:").ordered
  end

  def prompt_user_to_order_second_dish
    expect(io).to receive(:puts).with("Chips").ordered
    expect(io).to receive(:puts).with("Quantity:").ordered
  end

  describe "Order" do 
    it "allows user to order from the menu" do
      prompt_user_to_order_first_dish
      expect(io).to receive(:gets).and_return("1").ordered
      prompt_user_to_order_second_dish
      expect(io).to receive(:gets).and_return("2").ordered
      order.order_from(menu)
      expect(order.basket).to eq [{dish: "Calamari", quantity: 1, cost: 3}, {dish: "Chips", quantity: 2, cost: 4}]
    end

    it "fails to add a dish to the basket when given 0 quantity" do
      prompt_user_to_order_first_dish
      expect(io).to receive(:gets).and_return("1").ordered
      prompt_user_to_order_second_dish
      expect(io).to receive(:gets).and_return("0").ordered
      order.order_from(menu)
      expect(order.basket).to eq [{dish: "Calamari", quantity: 1, cost: 3}]
    end
  end

  describe "Confirmation" do
    it "returns a receipt for an order" do
      order.add(calamari, 5)
      order.add(chips, 5)
      # TODO: Why does replacing .order_id return value below with "1" result in rspec error?
      expect(confirmation.receipt).to eq ["Calamari x5 => £15", "Chips x5 => £10", "Grand total: £25", "Order ID: #{confirmation.order_id}. Order placed at: 10:00 by Tom"]
    end

    it "sends an sms confirming the order" do
      order.add(calamari, 5)
      order.add(chips, 5)
      foramtted_time = confirmation.order_time.strftime("%H:%M")
      @client = double(:@client)
      expect(messaging_module).to receive(:new).with('TWILIO_ACCOUNT_SID', 'TWILIO_AUTH_TOKEN').and_return(@client)
      # expect(messaging_module).to receive(:new).with('TWILIO_ACCOUNT_SID', 'TWILIO_AUTH_TOKEN').and_return(@client, messages: double("messages_object"))
      messages_object = double(:messages_object)
      expect(@client).to receive(:messages).and_return(messages_object)
      expect(messages_object).to receive(:create).with(
        body: "Hello Tom! Your order has been received and will be delivered by 11:00. Order ID: #{confirmation.order_id} ",
        from: '+14752646904',
        to: '+447917855547'
      ).and_return(double(:message, sid: "test_message_SID"))
      expect(Kernel).to receive(:puts).with("test_message_SID")
      confirmation.notify
    end
  end     
end