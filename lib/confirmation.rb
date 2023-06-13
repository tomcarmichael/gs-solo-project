require 'twilio-ruby'
require 'rubygems'

class Confirmation
  def initialize(order, receipt_class, messaging_module, io) # takes order object and Receipt class, Twilio::REST::Client, and Kernel
    @order = order
    @order_time = Time.now
    @receipt_class = receipt_class
    @messaging_module = messaging_module
    @io = io
    # @receipt = Receipt.new(order.basket)
  end

  def delivery_time # TO TEST
    # add the amount of seconds in an hour and display only hour:minutes
    (@order_time += 3600).strftime("%H:%M")
  end

  def order_id
    @order.order_id
  end

  def order_time
    @order_time
  end

  def receipt
    @receipt = @receipt_class.new(@order.basket) 
    @receipt.print << "Order ID: #{@order.order_id}. Order placed at: #{@order_time.strftime("%H:%M")} by #{@order.name}"
  end

  def notify
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    auth_token = ENV['TWILIO_AUTH_TOKEN']
    @client = @messaging_module.new(account_sid, auth_token)

    message = @client.messages
      .create(
        body: "Hello #{@order.name}! Your order has been received and will be delivered by #{delivery_time}. Order ID: #{@order.order_id} ",
        from: ENV['TWILIO_SENDER_NUMBER'],
        to: ENV['RECEIVER_PHONE_NUMBER']
      )
    @io.puts message.sid
  end
end


