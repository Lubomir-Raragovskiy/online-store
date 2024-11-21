class OrdersController < ApplicationController
  def new
    @order = Order.new(order_params)
    @order.build_address if @order.address.nil? # Створюємо адресу, якщо її немає
  end

  def create
    @order = current_user ? current_user.orders.build(order_params) : Order.new(order_params)

    (session[:cart] || []).each do |product_id|
      product = Product.find(product_id)
      @order.order_items.build(product: product, quantity: 1, price: product.price)
    end

    if @order.save
      session[:cart] = [] # Очищуємо кошик
      redirect_to @order, notice: "Замовлення успішно оформлено!"
    else
      render :new
    end
  end

  def update
    @order = Order.find(params[:id])

    if @order.update(order_params)
      redirect_to order_path(@order)
    else
      render :edit
    end
  end

  private

  def order_params
    params.fetch(:order, {}).permit(
      :name, :email, :phone, :payment_method,
      :card_number, :card_expiry, :card_cvc,
      address_attributes: [ :line1, :line2, :city, :district, :region, :postal_code ]
    )
  end
end
