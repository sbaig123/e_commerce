class CartsController < ApplicationController

  def show
    @order_items = current_user_order.order_items
  end

end
