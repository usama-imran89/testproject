# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :load_cart

  layout 'dinnerdash'
  def index
    @cart
    @categories_items = @cart.collect { |detail| CategoriesItem.where(:item_id=> detail.id) }.flatten
    @categories = @categories_items.collect { |detail| Category.where(:id=> detail.category_id) }.flatten
  end

  def count_items
    count = 0
    session[:cart].each do |key, value|
      count += value
    end
    count
  end

  def cal_price
    sum = 0
    @cart.each do |item|
      sum += session[:cart][item.id.to_s] * item.price
    end
    sum
  end
  helper_method :count_items, :cal_price
end
