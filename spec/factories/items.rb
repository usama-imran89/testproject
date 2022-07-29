# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    title { 'Juices' }
    description { 'Special Juices' }
    price { 440 }
    retire { false }
    quantity { 4 }
    user
  end
end
