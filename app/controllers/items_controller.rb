# frozen_string_literal: true

class ItemsController < ApplicationController
  rescue_from ActiveRecord::InvalidForeignKey, with: :belongs_to_entity
  rescue_from ActiveRecord::DeleteRestrictionError, with: :belongs_to_entity
  before_action :find_item, only: %i[edit update show destroy retire resume increase_item_qty decrease_item_qty add_to_cart]
  before_action :find_catgory, only: %i[new create edit]
  before_action :before_create_action, only: %i[create]
  before_action do
    session[:return_to] ||= request.referer
  end
  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
    authorize @item
  end

  def create
    if @item.save
      redirect_to category_path(@category), success: 'ITEM HAS BEEN CREATED'
    else
      render :new, danger: 'ITEM HAS NOT BEEN CREATED'
    end
  end

  def edit
    authorize @item
  end

  def update
    @item.categories_items.build(category_id: params[:item]['new_category'])
    if @item.update(post_params)
      redirect_to @item, success: 'ITEM HAS BEEN UPDATED'
    else
      render :edit, danger: 'CATEGORY HAS NOT BEEN EDITED'
    end
  end

  def destroy
    if OrdersItem.find_by(item_id: @item.id)
      redirect_to session.delete(:return_to), warning: 'ITEM Belongs TO AN ORDER YOU CANT DELETE IT'
    else
      @item_id =  @item.id
      @item.destroy
      respond_to do |format|
        format.html
        format.js
      end
    end
  end

  def add_to_cart
    session[:cart][params[:id]] = 1 unless session[:cart].include?(params[:id])
    redirect_to session.delete(:return_to), success: 'ITEM HAS BEEN ADDED'
  end

  def increase_item_qty
    session[:cart][params[:id]] += 1 unless session[:cart][params[:id]] + 1 > @item.quantity
    respond_to do |format|
      format.html
      format.js
    end
  end

  def remove_from_cart
    session[:cart].delete(params[:id]) if session[:cart].include?(params[:id])
    redirect_to session.delete(:return_to), warning: 'ITEM HAS BEEN REMOVED FROM YOUR CART'
  end

  def decrease_item_qty
    session[:cart][params[:id]] -= 1 if (session[:cart][params[:id]] - 1) >= 0
    session[:cart].delete(params[:id]) if session[:cart][params[:id]].zero?
    respond_to do |format|
      format.html
      format.js
    end
  end

  def retire
    @item.update(retire: true)
    redirect_to session.delete(:return_to), warning: 'ITEM RETIRED'
  end

  def resume
    @item.update(retire: false)
    redirect_to session.delete(:return_to), success: 'ITEM RESUMED'
  end

  private

  def post_params
    params.require(:item).permit(:title, :description, :price, :avatar, :retire, :quantity)
  end

  def find_item
    @item = Item.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render '/layouts/record_not_found'
  end

  def find_catgory
    @category = Category.find(params[:category_id])
  rescue ActiveRecord::RecordNotFound
    render '/layouts/record_not_found'
  end

  def belongs_to_entity
    redirect_to @category, notice: 'Can not  Destroy because this is belongs to an order You Just Retire This Item'
  end

  def before_create_action
    @item = @category.items.new(post_params)
    @item.categories_items.build(category_id: @category.id)
    @item.user_id = current_user.id
    @item.avatar.attach(io: File.open(Rails.root.join('app/assets/images/no_img.jpg')), filename: 'no_img.jpg') unless @item.avatar.attached?
  end
end
