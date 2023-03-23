class Confirmation
  def initialize(order) # takes order
    @order_id = order.order_id
    @order_time = order.order_time
    @receipt = Receipt.new(order.basket)
  end

  def delivery_time
    @order_time += 1 hour
  end

  def notify
    # use twilio gem to send user a text message confirming order and delivery time
    "Hello #{@order.name}! Your order number #{@order_id} has been received and will be delivered by #{@delivery_time}"
  end
end


