# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :load_cart

  layout 'dinnerdash'
  def index
    @cart
    @categories_items = @cart.collect { |detail| CategoriesItem.where(item_id: detail.id) }.flatten
    @categories = @categories_items.collect { |detail| Category.where(id: detail.category_id) }.flatten
  end
  include CartsHelper
end
