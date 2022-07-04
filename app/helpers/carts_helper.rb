# frozen_string_literal: true

module CartsHelper
  def count_items
    count = 0
    session[:cart].each do |_key, value|
      count += value
    end
    count
  end

  def cal_price(cart)
    sum = 0
    cart.each do |item|
      sum += session[:cart][item.id.to_s] * item.price
    end
    sum
  end
end
