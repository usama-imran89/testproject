# frozen_string_literal: true

class OrdersItem < ApplicationRecord
  belongs_to :item
  belongs_to :order
end
