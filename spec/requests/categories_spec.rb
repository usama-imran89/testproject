# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  it 'tests index of categories' do
    get categories_path
    expect(response).to have_http_status(:ok)
  end

  it 'tests show of categories' do
    get category_path(1)
    expect(response).to have_http_status(:ok)
  end
end
