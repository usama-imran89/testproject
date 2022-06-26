# frozen_string_literal: true

class ItemsController < ApplicationController
  rescue_from ActiveRecord::InvalidForeignKey, with: :belongs_to_entity
  rescue_from ActiveRecord::DeleteRestrictionError, with: :belongs_to_entity
  before_action :find_category
  before_action :find_item, only: %i[edit update show retire resume]

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
    authorize @item
  end

  def create
    @item = @category.items.new(post_params)
    @item.categories_items.build(category_id: @category.id)
    @item.user_id = current_user.id
    if @item.save
      redirect_to category_path(@category)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @item
  end

  def update
    @item.categories_items.build(category_id: params[:item]['new_category'])
    if @item.update(post_params)
      redirect_to @category, notice: 'Item updated'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    Item.destroy(params[:id])
  end

  def add_to_cart
    id = params[:id] # receving item id
    if session[:cart].include?(id)
      redirect_to category_path(params[:category_id])
    else
      session[:cart][id] = 1
    end
    redirect_to category_path(params[:category_id])
  end

  def increase_item_qty
    id = params[:id] # receving item id
    @item = Item.find(id)
    if session[:cart].include?(id)
      if session[:cart][id] + 1 <= @item.quantity
        session[:cart][id] += 1
      end
    end
  end

  def remove_from_cart
    id = params[:id]
    session[:cart].delete(id)
  end

  def decrease_item_qty
    id = params[:id] # receving item id
    if session[:cart].include?(id) && (session[:cart][id]-1) >=0
      session[:cart][id] -= 1
    end
    if  session[:cart].include?(id) && session[:cart][id].zero?
      session[:cart].delete(id)
    end
  end

  def retire
    @item.update(retire: true)
  end

  def resume
    @item.update(retire: false)
  end

  private

  def post_params
    params.require(:item).permit(:title, :description, :price, :avatar, :retire, :quantity)
  end

  def find_category
    @category = Category.find(params[:category_id])
  end

  def find_item
    @item = Item.find(params[:id])
  end

  def belongs_to_entity
    redirect_to @category, notice: 'Can not  Destroy because this is belongs to an order You Just Retire This Item'
  end
end
