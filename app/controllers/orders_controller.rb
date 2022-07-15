# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :load_cart
  before_action :authenticate_user!
  before_action :filtered_orders, only: %i[order_status]
  before_action :find_order, only: %i[show edit update]
  before_action :authorize_order, only: %i[edit update]
  include OrdersHelper
  def index
    @orders = policy_scope(Order)
  end

  def show
    authorize @order
    @items = @order.items
  end

  def create
    @order = Order.new
    check_out
    Order.transaction do
      if @order.save!
        session[:cart].clear
        redirect_to order_path(@order)
      else
        render :new, danger: 'Order HAS NOT BEEN CREATED'
      end
    end
  end

  def edit; end

  def update
    @order.update!(status: post_params['change_status'].to_i)
    redirect_to @order, success: 'STATUS HAS BEEN UPDATED'
  end

  def order_status
    @orders = @filtered_orders.where(status: @o_status)
    render 'index'
  end

  private

  def post_params
    params.require(:order).permit(:change_status)
  end

  def check_out
    @order.user_id = current_user.id
    @order.total_price = cal_price(@cart)
    build_order_items
    return if session[:cart].empty?
  end

  def filtered_orders
    @filtered_orders = policy_scope(Order)
    @o_status = request.path.split('/')[2]
  end

  def authorize_order
    authorize Order
  end

  def build_order_items
    session[:cart].each_key do |key|
      @order.orders_items.build(item_id: key, quantity: session[:cart][key].to_i)
    end
  end

  def find_order
    @order = Order.find(params[:id])
  end
end
