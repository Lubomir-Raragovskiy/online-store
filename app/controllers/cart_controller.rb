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
end
