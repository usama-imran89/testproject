class Item < ApplicationRecord
  belongs_to :user
  has_many :categories_items
  has_many :categories, through: :categories_items
end
