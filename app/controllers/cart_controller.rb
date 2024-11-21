class CartController < ApplicationController
  def create
    # Знаходимо продукт за переданим ID
    product = Product.find(params[:product_id])

    # Ініціалізуємо корзину в сесії, якщо вона ще не створена
    session[:cart] ||= []
    session[:cart] << product.id

    # Повертаємо користувача на сторінку каталогу з повідомленням
    redirect_to products_path, notice: "#{product.name} додано до кошика."
  end

  def show
    # Завантажуємо продукти, додані в корзину
    @cart_products = Product.find(session[:cart] || [])
  end

  def update
    # Знаходимо продукт за переданим ID
    product_id = params[:product_id].to_i

    desired_quantity = params[:quantity].to_i
    current_quantity = session[:cart].count { |id| id == product_id }

    quantity_to_add = desired_quantity - current_quantity

    # Якщо необхідно додати продукти, додаємо їх в кошик
    if quantity_to_add > 0
      quantity_to_add.times do
        session[:cart] << product_id
      end
    elsif quantity_to_add < 0
      # Якщо потрібно видалити зайві продукти
      quantity_to_remove = -quantity_to_add
      quantity_to_remove.times do
        session[:cart].delete_at(session[:cart].rindex(product_id))
      end
    end

    # Повертаємо користувача на сторінку кошика
    redirect_to cart_path
  end

  def remove
    product_id = params[:product_id].to_i

    if session[:cart].include?(product_id)
      session[:cart].delete_if { |id| id == product_id }
    end

    redirect_to cart_path
  end
end
