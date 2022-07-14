# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :load_cart
  before_action :authenticate_user!
  before_action :filtered_orders, only: %i[order_status]
  before_action :find_order, only: %i[show]
  before_action :authorize_order, except: %i[index create show]
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
        render status: :not_found
      end
    end
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    Order.transaction do
      @order.update!(status: (params['order']['change_status']).to_i)
      redirect_to @order, success: 'STATUS HAS BEEN UPDATED'
    end
  end

  def order_status
    @orders = @filtered_orders.where(status: @o_status)
    render 'index'
  end

  private

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
