class Admin::OrdersController < Admin::SessionController
  def index
    @orders = Order.all
  end

  def destroy
    @order = Order.find(params[:id])
    if @order.destroy
      flash[:notice] = "Замовлення успішно видалено."
    else
      flash[:alert] = "Не вдалося видалити замовлення."
    end
    redirect_to admin_orders_path
  end
end
