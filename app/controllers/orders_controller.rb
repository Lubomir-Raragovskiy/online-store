class OrdersController < ApplicationController
  before_action :load_regions_and_related_data, only: [ :new, :create ]

  def new
    @order = Order.new
    @order.build_address
  end

  def create
    @order = current_user ? current_user.orders.build(order_params) : Order.new(order_params)

    # Додаємо продукти з кошика в замовлення
    (session[:cart] || []).each do |product_id|
      product = Product.find(product_id)
      @order.order_items.build(product: product, quantity: 1, price: product.price)
    end

    if @order.save
      session[:cart] = [] # Очищуємо кошик

      # Надсилаємо підтвердження замовлення
      OrderMailer.order_confirmation(@order).deliver_now

      redirect_to @order, notice: "Замовлення успішно оформлено! Перевірте вашу електронну пошту."
    else
      render :new
    end
  end

  private

  def order_params
    permitted = [ :name, :email, :phone, :payment_method,
                 { address_attributes: [ :region, :district, :settlement, :post_office ] } ]
    if params[:order][:payment_method] == "card"
      permitted += [ :card_number, :card_expiry_month, :card_expiry_year, :card_cvc ]
    end
    params.require(:order).permit(permitted)
  end

  def load_regions_and_related_data
    @regions = DelengineApiService.fetch_regions || []
    @districts = params[:region_id].present? ? DelengineApiService.fetch_districts(params[:region_id]) : []
    @settlements = params[:district_id].present? ? DelengineApiService.fetch_settlements(params[:district_id]) : []
    @post_offices = params[:settlement_id].present? ? DelengineApiService.fetch_post_offices(params[:settlement_id]) : []
  end
end
