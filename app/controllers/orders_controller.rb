class OrdersController < ApplicationController
  def new
    @order = Order.new
    @cart_products = Product.find(session[:cart] || [])
  end

  def create
    @order = current_user ? current_user.orders.build(order_params) : Order.new(order_params)

    # Додаємо товари з кошика до замовлення
    cart_items = session[:cart] || []
    cart_items.each do |product_id|
      product = Product.find(product_id)
      @order.order_items.build(product: product, quantity: 1, price: product.price)
    end

    if @order.save
      session[:cart] = [] # Очищуємо кошик
      redirect_to @order, notice: "Замовлення успішно оформлено!"
    else
      @cart_products = Product.find(session[:cart] || [])
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:name, :email, :phone)
  end
end
