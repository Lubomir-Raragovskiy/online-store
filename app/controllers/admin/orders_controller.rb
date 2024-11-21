class Admin::OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  def index
    @orders = Order.all
  end
end
