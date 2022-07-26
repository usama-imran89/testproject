# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Item, type: :model do
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to validate_presence_of(:quantity) }
  it { is_expected.to have_one_attached(:avatar) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:categories_items).dependent(:delete_all) }
  it { is_expected.to have_many(:categories).through(:categories_items) }
  it { is_expected.to have_many(:orders_items).dependent(:delete_all) }
  it { is_expected.to have_many(:orders).through(:orders_items) }

  it 'returns no error messages for correct avatar type' do
    file = Rails.root.join('app/assets/images/buryani.jpg')
    image = ActiveStorage::Blob.create_after_upload!(io: File.open(file, 'rb'), filename: 'buryani.jpg').signed_id
    assign_img = described_class.new(avatar: image)
    assign_img.send(:correct_avatar)
    expect(assign_img.errors.messages).to eq({})
  end

  it 'returns error messages for avatar image type' do
    file = Rails.root.join('app/assets/images/chines.pdf')
    image = ActiveStorage::Blob.create_after_upload!(io: File.open(file, 'rb'), filename: 'chines.pdf').signed_id
    assign_img = described_class.new(avatar: image)
    assign_img.send(:correct_avatar)
    expect(assign_img.errors.messages).not_to be_nil
  end

  it 'returns error messages for avatar image sise' do
    file = Rails.root.join('app/assets/images/image_size.jpg')
    image = ActiveStorage::Blob.create_after_upload!(io: File.open(file, 'rb'), filename: 'image_size.jpg').signed_id
    assign_img = described_class.new(avatar: image)
    assign_img.send(:correct_avatar)
    expect(assign_img.errors.messages).not_to be_nil
  end
end
