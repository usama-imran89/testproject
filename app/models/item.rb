# frozen_string_literal: true

class Item < ApplicationRecord
  validates :title, :description, :price, :quantity, presence: true
  has_one_attached :avatar
  belongs_to :user
  has_many :categories_items, dependent: :delete_all
  has_many :categories, through: :categories_items
  has_many :orders_items, dependent: :delete_all
  has_many :orders, through: :orders_items
end
