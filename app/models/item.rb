class Item < ApplicationRecord
  has_one_attached :avatar
  belongs_to :user
  has_many :categories_items
  has_many :categories, through: :categories_items
end
