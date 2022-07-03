# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :title, null: false, default: ''
      t.text :description, null: false, default: ''
      t.integer :price, null: false, default: 5
      t.references :user, foreign_key: true, null: false, default: 'Xam'

      t.timestamps
    end
  end
end
