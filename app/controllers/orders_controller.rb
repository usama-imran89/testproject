# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :load_cart
  before_action :authenticate_user!
  before_action :filtered_orders, only: %i[delivered pending canceled]
  before_action only: %i[show] do
    @order = Order.find(params[:id])
  end
  layout 'dinnerdash'

  def index
    @orders = policy_scope(Order)
  end

  def show
    @order_detail = OrdersItem.where(order_id: @order.id)
    @items = @order_detail.collect { |detail| Item.where(id: detail.item_id) }.flatten
  end

  def create
    @order = Order.new
    check_out
    if @order.save
      redirect_to order_path(@order)
    else
      render status: :not_found
    end
  end

  def edit
    @order = Order.find(params[:id])
    authorize @order
  end

  def update;end

  def pending
    @orders = @filtered_orders.where(status: 'pending')
    render 'index'
  end

  def delivered
    @orders = @filtered_orders.where(status: 'delivered')
    render 'index'
  end

  def canceled
    @orders = @filtered_orders.where(status: 'cancelled')
    render 'index'
  end

  private

  def check_out # rubocop:disable Metrics/AbcSize
    if !session[:cart].empty?
      @order.user_id = current_user.id
      @order.total_price = cal_price
      @order.save
      session[:cart].each_key do |key|
        @order.orders_items.build(item_id: key, quantity: session[:cart][key].to_i)
      end
      @save_keys = session[:cart].keys
      session[:cart].clear
    end
  end

  def cal_price
    sum = 0
    @cart.each do |item|
      sum += session[:cart][item.id.to_s] * item.price
    end
    sum
  end

  def filtered_orders
    @filtered_orders = policy_scope(Order)
  end
end
