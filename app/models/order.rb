class Order < ApplicationRecord
  belongs_to :user
  has_many :orders_items
  has_many :orders, through: :orders_items
  enum status:[:pending, :delivered, :cancelled]
  after_initialize do
    if self.new_record?
      self.status ||=:pending
    end
  end
end
