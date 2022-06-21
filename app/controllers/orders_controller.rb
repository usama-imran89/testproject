class OrdersController < ApplicationController
  def index
   # @orders=Order.all
    #@orders_items=OrdersItem.all
  end
  def show
    @order=Order.find(params[:id])
  end
  def create
    @order=Order.new
    check_out
    if @order.save
      redirect_to order_path(@order)
    else
      render status: 404
    end
  end

  def check_out
    @order.user_id = current_user.id
    @order.save # we have to save order first otherwise @order.order_items. return nill due to empty class of order
    session[:cart].each_key do |key|
      @order.orders_items.build(item_id:key)
    end
    session[:cart].clear
  end

end
