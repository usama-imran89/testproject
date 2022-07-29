# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:orders_items).dependent(:restrict_with_exception) }
  it { is_expected.to have_many(:items).through(:orders_items) }
  it { is_expected.to define_enum_for(:status).with_values(pending: 0, delivered: 1, cancelled: 2) }
end
