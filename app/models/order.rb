# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user
  has_many :orders_items, dependent: :restrict_with_exception
  has_many :items, through: :orders_items
  enum status: { pending: 0, delivered: 1, cancelled: 2 }
end
