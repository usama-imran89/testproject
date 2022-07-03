# frozen_string_literal: true

module OrdersHelper
  def cal_price(cart)
    sum = 0
    cart.each do |item|
      sum += session[:cart][item.id.to_s] * item.price
    end
    sum
  end
end
