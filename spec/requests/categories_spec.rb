# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'faker'

RSpec.describe 'Categories', type: :request do
  let(:user) { create :user }
  let(:cat) { create(:category, user: user) }
  let(:itm) { create(:item, user: user) }

  before do
    sign_in user
  end

  it 'tests index of categories' do
    get categories_path
    expect(response).to have_http_status(:ok)
  end

  it 'tests show of categories' do
    get category_path(cat.id)
    expect(response).to have_http_status(:ok)
  end

  it 'test new action of categories' do
    get new_category_path
    expect(response).to render_template('categories/new')
  end

  it 'tests the delete action method of category' do
    delete category_path(cat.id)
    expect(response).to redirect_to(root_path)
  end

  it 'tests the faliur delete action method of category' do
    cat.categories_items.build(item_id: itm.id)
    cat.save
    delete category_path(cat.id)
    expect(response).to redirect_to(root_path)
  end

  it 'tests the create action method of categories' do
    expect do
      post categories_path, params: { category: { name: Faker::Name.name, user_id: user.id } }
    end.to change(Category, :count).by(1)
  end

  it 'tests the faliur case of create action method of categories' do
    post categories_path, params: { category: { name: '', user_id: user.id } }
    expect(response).to render_template('new')
  end

  it 'tests the update action method of categories' do
    patch category_path(cat.id), params: { id: cat.id, category: { name: 'RSpec Test Category' } }
    expect(response).to redirect_to(cat)
  end

  it 'tests the faliur case of update action method of categories' do
    patch category_path(cat.id), params: { id: cat.id, category: { name: '' } }
    expect(response).to render_template('edit')
  end
end
