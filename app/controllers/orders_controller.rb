class OrdersController < ApplicationController
  before_action :load_regions_and_related_data, only: [ :new, :create ]

  def new
    @order = Order.new
    @order.build_address
  end

  def create
    @order = current_user ? current_user.orders.build(order_params) : Order.new(order_params)

    unless params.dig(:order, :from_button) == "true"
      render :new and return
    end

    (session[:cart] || []).each do |product_id|
      product = Product.find(product_id)
      @order.order_items.build(product: product, quantity: 1, price: product.price)
      product.stock -=1
      product.save
    end

    if @order.save
      session[:cart] = [] # Очищуємо кошик

      # Надсилаємо підтвердження замовлення
      OrderMailer.order_confirmation(@order).deliver_now

      redirect_to order_path(@order), notice: "Замовлення успішно оформлено! Перевірте вашу електронну пошту."
    else
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])
  end


  private

  def order_params
    permitted = [ :name, :email, :phone, :payment_method, :from_button,
                 { address_attributes: [ :region, :district, :settlement, :post_office ] } ]
    if params[:order][:payment_method] == "card"
      permitted += [ :card_number, :card_expiry_month, :card_expiry_year, :card_cvc ]
    end
    params.require(:order).permit(permitted)
  end

  def load_regions_and_related_data
    @regions = DelengineApiService.fetch_regions || []
    region_id = params.dig(:order, :address_attributes, :region)
    @districts = region_id.present? ? DelengineApiService.fetch_districts(region_id) : []
    district_id = params.dig(:order, :address_attributes, :district)
    @settlements = district_id.present? ? DelengineApiService.fetch_settlements(district_id) : []
    settlement_id = params.dig(:order, :address_attributes, :settlement)
    if settlement_id.present?
      post_offices_data = DelengineApiService.fetch_post_offices(settlement_id)
      @post_offices = post_offices_data.map do |post_office|
        {
          uuid: post_office["uuid"],
          label: "#{post_office['company']['name_uk']} - #{post_office['department_type']['name_uk']} - #{post_office['address_uk']}"
        }
      end
    else
      @post_offices = []
    end
  end
end
