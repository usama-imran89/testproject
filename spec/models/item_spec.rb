# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Item, type: :model do
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to validate_presence_of(:quantity) }
  it { is_expected.to have_many(:categories_items).dependent(:delete_all) }
  it { is_expected.to have_many(:categories).through(:categories_items) }
  it { is_expected.to have_many(:orders_items).dependent(:delete_all) }
  it { is_expected.to have_many(:orders).through(:orders_items) }
end
