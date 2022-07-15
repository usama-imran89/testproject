# frozen_string_literal: true

class Category < ApplicationRecord
  validates :name, presence: true
  validate :correct_avatar
  has_one_attached :avatar
  belongs_to :user
  has_many :categories_items, dependent: :restrict_with_exception
  has_many :items, through: :categories_items
end
