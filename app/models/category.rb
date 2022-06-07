class Category < ApplicationRecord
  belongs_to :user
  has_many :categories_items
  has_many :items, through: :categories_items
end
