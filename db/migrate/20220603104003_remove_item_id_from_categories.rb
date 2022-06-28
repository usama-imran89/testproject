# frozen_string_literal: true

class RemoveItemIdFromCategories < ActiveRecord::Migration[5.2]
  def change
    remove_column :categories, :item_id, :integer
  end
end
