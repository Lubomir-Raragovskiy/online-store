class OrderMailer < ApplicationMailer
  def order_confirmation(order)
    @order = order
    mail(
      to: @order.email,
      subject: "Підтвердження замовлення"
    )
  end
end
