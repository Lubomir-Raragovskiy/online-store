class ReviewsController < ApplicationController
  before_action :set_product
  before_action :authenticate_user!, only: [ :create, :destroy ]

  def create
    @review = @product.reviews.new(review_params)
    @review.user = current_user

    if @review.save
      redirect_to @product, notice: "Відгук додано!"
    else
      redirect_to @product, alert: "Не вдалося додати відгук."
    end
  end

  def destroy
    @review = @product.reviews.find(params[:id])
    if @review.user == current_user
      @review.destroy
      redirect_to @product, notice: "Відгук видалено!"
    else
      redirect_to @product, alert: "Ви не можете видалити цей відгук."
    end
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def review_params
    params.require(:review).permit(:rating, :content)
  end
end
