# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :load_cart
  def index
    @items = Item.where(id: @cart)
  end
end
