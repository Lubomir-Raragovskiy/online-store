class PagesController < ApplicationController
  def home
    @featured_products = Product.order(created_at: :desc).limit(3)
  end
end
