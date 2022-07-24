# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'faker'

RSpec.describe 'Items', type: :request do
  let(:user)  { create :user }
  let(:cat1)  { create(:category, user: user) }
  let(:itm)   { create(:item, user: user) }
  let(:order) { create(:order, user: user) }

  before do
    sign_in user
  end

  it 'test new action of items' do
    get new_category_item_path(cat1.id)
    expect(response).to have_http_status(:ok)
  end

  it 'tests show of items' do
    get item_path(itm.id)
    expect(response).to have_http_status(:ok)
  end

  it 'tests the edit fo items' do
    itm.categories_items.build(category_id: cat1.id)
    itm.save
    get edit_item_path(cat1.id, itm.id)
    expect(response).to render_template('edit')
  end

  it 'tests the create action method of items' do
    post category_items_path(cat1.id), params: { item: { title: itm.title, description: itm.description,
                                                         quantity: itm.quantity, retire: itm.retire } }
    expect(response).to redirect_to(cat1)
  end

  it 'tests the update action method of items' do
    patch item_path(itm.id), params: { item: { title: 'Dummy Item', new_category: cat1.id } }
    expect(response).to redirect_to(itm)
  end

  it 'tests the faliur case of update action method of items' do
    patch item_path(itm.id), params: { item: { title: '', new_category: cat1.id } }
    expect(response).to render_template('edit')
  end

  it 'tests the faliur case of create action method of items' do
    post category_items_path(cat1.id), params: { item: { title: '', description: itm.description,
                                                         quantity: itm.quantity, retire: itm.retire } }
    expect(response).to render_template('new')
  end

  it 'tests the delete action method of item' do
    delete item_path(itm.id), xhr: true
    expect(response).to have_http_status(:ok)
  end

  it 'tests the faliur of delete action of item' do
    order.orders_items.build(item_id: itm.id)
    order.save
    delete item_path(itm.id), headers: { 'HTTP_REFERER' => root_path }
  end

  it 'tests retire of items' do
    post retire_item_path(itm.id), params: { item: { retire: true } }, headers: { 'HTTP_REFERER' => root_path }
  end

  it 'tests resume of items' do
    post resume_item_path(itm.id), params: { item: { retire: false } }, headers: { 'HTTP_REFERER' => root_path }
  end

  it 'tests the add to cart' do
    allow_any_instance_of(ActionDispatch::Request).to receive(:session) {
                                                        { cart: { itm.id.to_s => 1 },
                                                          return_to: { 'HTTP_REFERER' => root_path } } }
    post add_to_cart_item_path(itm), params: { id: itm.id }
  end

  it 'tests the remove from cart' do
    allow_any_instance_of(ActionDispatch::Request).to receive(:session) {
                                                        { cart: { itm.id.to_s => 1 },
                                                          return_to: { 'HTTP_REFERER' => root_path } } }
    delete remove_from_cart_item_path(itm.id), params: { id: itm.id }
  end

  it 'tests the increase item quantity method of item' do
    allow_any_instance_of(ActionDispatch::Request).to receive(:session) { { cart: { itm.id.to_s => 2 } } }
    post increase_item_qty_item_path(itm.id), params: { id: itm.id }, xhr: true
    expect(response).to have_http_status(:ok)
  end

  it 'tests the decrease item quantity method of item' do
    allow_any_instance_of(ActionDispatch::Request).to receive(:session) { { cart: { itm.id.to_s => 2 } } }
    post decrease_item_qty_item_path(itm.id), params: { id: itm.id }, xhr: true
    expect(response).to have_http_status(:ok)
  end
end
