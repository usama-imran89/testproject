# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    id { 1 }
    name { 'Chines Rice' }
    avatar { Rack::Test::UploadedFile.new('app/assets/images/buryani.jpg', 'image/png') }
    user
  end
end
