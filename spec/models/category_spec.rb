# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to have_one_attached(:avatar) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:categories_items).dependent(:restrict_with_exception) }
  it { is_expected.to have_many(:items).through(:categories_items) }
end
