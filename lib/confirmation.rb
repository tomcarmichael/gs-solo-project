require 'twilio-ruby'
require 'rubygems'

class Confirmation
  def initialize(order, receipt_class) # takes order object and Receipt class
    @order = order
    @order_time = Time.now
    @receipt_class = receipt_class
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

  def notify # TODO
    # use twilio gem to send user a text message confirming order and delivery time
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    auth_token = ENV['TWILIO_AUTH_TOKEN']
    @client = Twilio::REST::Client.new(account_sid, auth_token)

    message = @client.messages
      .create(
        body: "Hello #{@order.name}! Your order has been received and will be delivered by #{delivery_time}. Order ID: #{@order.order_id} ",
        from: '+14752646904',
        to: '+447917855547'
      )
    puts message.sid
  end
end


