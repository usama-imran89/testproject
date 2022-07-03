# frozen_string_literal: true

class AddColomnToItems < ActiveRecord::Migration[5.2]
  def change
    change_table :items, bulk: true do
      add_column :items, :retire, :bool, null: false, default: false
      add_column :items, :quantity, :integer, null: false, default: 1
    end
  end
end
