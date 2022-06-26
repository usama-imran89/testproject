# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :title
      t.text :description
      t.integer :price
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
