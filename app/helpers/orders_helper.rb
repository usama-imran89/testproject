# frozen_string_literal: true

module OrdersHelper
  def cal_price(cart)
    sum = 0
    cart.each do |item|
      sum += session[:cart][item.id.to_s] * item.price
    end
    sum
  end

  def cal_date_diff(order)
    if (order.updated_at - order.created_at).positive?
      order.updated_at
    else
      ''
    end
  end
end
