class Category < ApplicationRecord
  has_one_attached :avatar
  belongs_to :user
  has_many :categories_items
  has_many :items, through: :categories_items
end
