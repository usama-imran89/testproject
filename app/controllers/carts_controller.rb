class CartsController < ApplicationController
  before_action :load_cart

  layout "dinnerdash"
  def index
    @cart
  end
  def count_items
    count=0
    session[:cart].each do |key, value|
       count=count+value
    end
    return count
  end
  def cal_price
    sum=0
    @cart.each do |item|
      sum=sum+session[:cart][item.id.to_s] * item.price
    end
    return sum
  end
  helper_method :count_items, :cal_price
end
