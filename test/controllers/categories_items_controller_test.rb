# frozen_string_literal: true

require 'test_helper'

class CategoriesItemsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get categories_items_index_url
    assert_response :success
  end
end
