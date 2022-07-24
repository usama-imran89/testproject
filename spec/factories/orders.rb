# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    status { 'pending' }
    total_price { 4 }
    user
  end
end
