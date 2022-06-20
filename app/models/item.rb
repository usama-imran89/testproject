class Item < ApplicationRecord
  validates :title,:description,:price, presence: true
  has_one_attached :avatar
  belongs_to :user
  has_many :categories_items
  has_many :categories, through: :categories_items
  has_many :orders_items
  has_many :orders, through: :orders_items
end
