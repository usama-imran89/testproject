# frozen_string_literal: true

class AddNameToUsers < ActiveRecord::Migration[5.2]
  def change
    change_table :users, bulk: true do
      add_column :users, :fname, :string, null: false, default: 'Xam'
      add_column :users, :lname, :string, default: ''
    end
  end
end
