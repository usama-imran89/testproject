# frozen_string_literal: true

class AddTotalPriceToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :total_price, :integer
  end
end
