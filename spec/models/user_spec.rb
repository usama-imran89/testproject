# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of(:fname) }
  it { is_expected.to validate_presence_of(:lname) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to have_many(:items).dependent(:restrict_with_exception) }
  it { is_expected.to have_many(:categories).dependent(:restrict_with_exception) }
  it { is_expected.to have_many(:orders).dependent(:restrict_with_exception) }
  it { is_expected.to define_enum_for(:role).with_values(standard: 0, admin: 1) }
end
