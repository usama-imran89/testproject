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

  describe 'GET /index' do
    context 'when display all categories' do
      it 'tests the http status' do
        get categories_path
        expect(response).to have_http_status(:ok)
      end

      it 'tests assign of @categories' do
        get categories_path
        expect(assigns(:categories)).to eq(Category.all)
      end
    end
  end

  describe 'GET /show' do
    context 'when display all items when category exists' do
      it 'tests show of categories' do
        get category_path(cat.id)
        expect(response).to have_http_status(:ok)
      end

      it 'tests assign of @items' do
        get categories_path
        expect(assigns(:items)).to be_nil
      end
    end

    context 'when display all items when not category exists' do
      it 'tests when record not found' do
        get category_path(4234)
        expect(response).to render_template('layouts/record_not_found')
      end
    end
  end

  describe 'GET /edit' do
    context 'when category will edit' do
      it 'tests the edit fo category' do
        get edit_category_path(cat.id)
        expect(response).to render_template('edit')
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET /new' do
    context 'when create new category' do
      it 'test new action of categories' do
        get new_category_path
        expect(response).to render_template('categories/new')
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'POST /create' do
    context 'when create new category' do
      it 'tests category created successfully' do
        expect do
          post categories_path, params: { category: { name: Faker::Name.name, user_id: user.id } }
        end.to change(Category, :count).by(1)
        expect(flash[:success]).to eq('CATEGORY HAS BEEN CREATED SUCCESSFULLY')
      end
    end

    context 'when category not created' do
      it 'tests the faliur case when name filed is empty' do
        post categories_path, params: { category: { name: '', user_id: user.id } }
        expect(response).to render_template('new')
        expect(flash[:danger]).to eq('CATEGORY HAS NOT BEEN CREATED')
      end
    end
  end

  describe 'PATCH /update' do
    context 'when update category' do
      it 'tests the update action method of categories' do
        patch category_path(cat.id), params: { id: cat.id, category: { name: 'RSpec Test Category' } }
        expect(response).to redirect_to(cat)
        expect(flash[:success]).to eq('CATEGORY HAS BEEN UPDATED SUCCESSFULLY')
      end
    end

    context 'when category not updated' do
      it 'tests the faliur case of update when name filed is empty' do
        patch category_path(cat.id), params: { id: cat.id, category: { name: '' } }
        expect(response).to render_template('edit')
        expect(flash[:danger]).to eq('CATEGORY HAS NOT BEEN UPDATED')
      end

      it 'tests the faliur case of update when name category not exists' do
        patch category_path(3221), params: { id: cat.id, category: { name: 'RSpec Test Category' } }
        expect(response).to render_template('layouts/record_not_found')
      end
    end
  end

  describe 'DELETE /destroy' do
    context 'when destroy category successfully' do
      it 'tests the delete action method of category' do
        delete category_path(cat.id)
        expect(response).to redirect_to(root_path)
        expect(flash[:success]).to eq('CATEGORY DESTROY SUCCESSFULLY')
      end
    end

    context 'when category will not destroy' do
      it 'tests the faliur delete action when category has items' do
        cat.categories_items.build(item_id: itm.id)
        cat.save
        delete category_path(cat.id)
        expect(response).to redirect_to(root_path)
        expect(flash[:danger]).to eq('CATEGORY CAN NOT BE DESTROY, IT HAS MANY ITEMS')
      end
    end
  end
end
