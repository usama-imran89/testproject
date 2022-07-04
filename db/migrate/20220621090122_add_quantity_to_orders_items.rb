# frozen_string_literal: true

class AddQuantityToOrdersItems < ActiveRecord::Migration[5.2]
  def change
    add_column :orders_items, :quantity, :integer, default: 0
  end
end
