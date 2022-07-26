# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'faker'

RSpec.describe 'Items', type: :request do
  let(:user) { create :user }
  let(:category) { create(:category, user: user) }
  let(:itm)   { create(:item, user: user) }
  let(:order) { create(:order, user: user) }

  before do
    sign_in user
  end

  # Controller Actions
  describe 'GET /show' do
    context 'when item exists' do
      it 'tests show of items' do
        get item_path(itm.id)
        expect(response).to have_http_status(:ok)
        expect(assigns(:item).class.name).to eq('Item')
      end
    end

    context 'when item does not exixts' do
      it 'tests when record not found' do
        get item_path(4444)
        expect(response).to render_template('layouts/record_not_found')
      end
    end
  end

  describe 'GET /new' do
    context 'when create new item' do
      it 'test new action of items' do
        get new_category_item_path(category.id)
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'POST /create' do
    context 'when item creates successfully' do
      it 'tests the create action of items' do
        post category_items_path(category.id), params: { item: { title: itm.title, description: itm.description,
                                                                 quantity: itm.quantity, retire: itm.retire } }
        expect(response).to redirect_to(category)
        expect(flash[:success]).to eq('ITEM HAS BEEN CREATED')
      end
    end

    context 'when item not created' do
      it 'tests the faliur of create action of items' do
        post category_items_path(category.id), params: { item: { title: '', description: itm.description,
                                                                 quantity: itm.quantity, retire: itm.retire } }
        expect(response).to render_template('new')
        expect(flash[:danger]).to eq('ITEM HAS NOT BEEN CREATED')
      end
    end
  end

  describe 'GET /edit' do
    context 'when item will edit' do
      it 'tests the edit fo items' do
        itm.categories_items.build(category_id: category.id)
        itm.save
        get edit_item_path(category.id, itm.id)
        expect(response).to render_template('edit')
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'POST /update' do
    context 'when item updated successfully' do
      it 'tests the update action method of items' do
        patch item_path(itm.id), params: { item: { title: 'Dummy Item', new_category: category.id } }
        expect(response).to redirect_to(itm)
        expect(flash[:success]).to eq('ITEM HAS BEEN UPDATED')
        expect(response).to have_http_status(:found)
      end
    end

    context 'when item not updated' do
      it 'tests the faliur case of update action method of items' do
        patch item_path(itm.id), params: { item: { title: '', new_category: category.id } }
        expect(response).to render_template('edit')
        expect(flash[:danger]).to eq('ITEM HAS NOT BEEN EDITED')
      end
    end
  end

  describe 'DELETE /destroy' do
    context 'when item deleted successfully' do
      it 'tests the delete action method of item' do
        delete item_path(itm.id), xhr: true
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when item not deleted' do
      it 'tests the faliur of delete action of item' do
        order.orders_items.build(item_id: itm.id)
        order.save
        delete item_path(itm.id), headers: { 'HTTP_REFERER' => root_path }
        expect(flash[:warning]).to eq('ITEM Belongs TO AN ORDER YOU CANT DELETE IT')
      end
    end
  end

  describe 'POST /add_to_cart' do
    context 'when item add to cart' do
      it 'tests the add to cart' do
        allow_any_instance_of(ActionDispatch::Request).to receive(:session) {
                                                            { cart: { itm.id.to_s => 1 },
                                                              return_to: { 'HTTP_REFERER' => root_path } }
                                                          }
        post add_to_cart_item_path(itm), params: { id: itm.id }
        expect(flash[:success]).to eq('ITEM HAS BEEN ADDED')
      end
    end
  end

  describe 'DELETE /remove_from_cart' do
    context 'when item remove from cart' do
      it 'tests the remove from cart' do
        allow_any_instance_of(ActionDispatch::Request).to receive(:session) {
                                                            { cart: { itm.id.to_s => 1 },
                                                              return_to: { 'HTTP_REFERER' => root_path } }
                                                          }
        delete remove_from_cart_item_path(itm.id), params: { id: itm.id }
        expect(flash[:warning]).to eq('ITEM HAS BEEN REMOVED FROM YOUR CART')
      end
    end
  end

  describe 'POST /increase_item_qty' do
    context 'when item quantity increased' do
      it 'tests the increase item quantity method of item' do
        allow_any_instance_of(ActionDispatch::Request).to receive(:session) { { cart: { itm.id.to_s => 2 } } }
        post increase_item_qty_item_path(itm.id), params: { id: itm.id }, xhr: true
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'POST /decrease_item_qty' do
    context 'when item quantity decreased' do
      it 'tests the decrease item quantity method of item' do
        allow_any_instance_of(ActionDispatch::Request).to receive(:session) { { cart: { itm.id.to_s => 2 } } }
        post decrease_item_qty_item_path(itm.id), params: { id: itm.id }, xhr: true
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'POST /retire' do
    context 'when item retired from stock' do
      it 'tests retire of items' do
        post retire_item_path(itm.id), params: { item: { retire: true } }, headers: { 'HTTP_REFERER' => root_path }
        expect(flash[:warning]).to eq('ITEM RETIRED')
        expect(response).to have_http_status(:found)
      end
    end
  end

  describe 'POST /resume' do
    context 'when item resumed to stock' do
      it 'tests resume of items' do
        post resume_item_path(itm.id), params: { item: { retire: false } }, headers: { 'HTTP_REFERER' => root_path }
        expect(flash[:success]).to eq('ITEM RESUMED')
        expect(response).to have_http_status(:found)
      end
    end
  end
end
