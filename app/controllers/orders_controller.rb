class OrdersController < ApplicationController
  before_action :load_cart
  before_action :authenticate_user!
  layout"dinnerdash"

  def index
  end
  def show
    @order=Order.find(params[:id])
    @order_detail=OrdersItem.where(order_id:@order.id)
    @items=Item.all
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
  def history
    @orders=Order.all
    @order_details=OrdersItem.all
    byebug
  end
  private
  def check_out
    if !session[:cart].empty?
      @order.user_id = current_user.id
      @order.total_price = cal_price
      @order.save # we have to save order first otherwise @order.order_items. return nill due to empty class of order
      session[:cart].each_key do |key|
        @order.orders_items.build(item_id:key, quantity:session[:cart][key].to_i)
      end
      @save_keys=session[:cart].keys
      session[:cart].clear
    end
  end
  def cal_price
    sum=0
    @cart.each do |item|
      sum=sum+session[:cart][item.id.to_s] * item.price
    end
    return sum
  end

end
