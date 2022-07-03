# frozen_string_literal: true

class CreateOrdersItems < ActiveRecord::Migration[5.2]
  def change
    create_table :orders_items do |t|
      t.references :item, foreign_key: true
      t.references :order, foreign_key: true
      t.timestamps
    end
  end
end
