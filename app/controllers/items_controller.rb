# frozen_string_literal: true

class ItemsController < ApplicationController
  rescue_from ActiveRecord::InvalidForeignKey, with: :belongs_to_entity
  rescue_from ActiveRecord::DeleteRestrictionError, with: :belongs_to_entity
  before_action :find_category
  before_action :find_item, only: %i[edit update show retire resume]
  include ItemsHelper
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
    unless @item.avatar.attached?
      @item.avatar.attach(io: File.open(Rails.root.join('app/assets/images/no_img.jpg')), filename: 'no_img.jpg')
    end
    if @item.save
      redirect_to category_path(@category), notice: 'ITEM HAS BEEN CREATED'
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
      redirect_to @category, notice: 'Item HAS BEEN'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    Item.destroy(find_item_by_params(params[:id]))
    redirect_to @category, notice: 'ITEM HAS BEEN DELETED'
  end

  def add_to_cart
    if session[:cart].include?(params[:id])
      redirect_to @category
    else
      session[:cart][params[:id]] = 1
    end
    redirect_to session.delete(:return_to), notice: 'ITEM HAS BEEN ADDED'
  end

  def increase_item_qty
    @item = Item.find(params[:id])
    if session[:cart].include?(params[:id])
      if session[:cart][params[:id]] + 1 <= @item.quantity
        session[:cart][params[:id]] += 1
      end
    end
    redirect_to session.delete(:return_to), notice: "YOU ADDED #{session[:cart][params[:id]]} #{Item.find_by(id: params[:id]).title.upcase} IN YOUR CART"
  end

  def remove_from_cart
    session[:cart].delete(find_item_by_params(params[:id]))
    redirect_to session.delete(:return_to), notice: 'ITEM HAS BEEN REMOVED FROM YOUR CART'
  end

  def decrease_item_qty # rubocop:disable Metrics/AbcSize
    if session[:cart].include?(find_item_by_params(params[:id])) && (session[:cart][params[:id]] - 1) >= 0
      session[:cart][params[:id]] -= 1
    end
    if  session[:cart].include?(params[:id]) && session[:cart][params[:id]].zero?
      session[:cart].delete(params[:id])
    end
    redirect_to session.delete(:return_to), notice: "1 #{Item.find_by(id: params[:id]).title.upcase} HAS BEEN REMOVED FROM CART"
  end

  def retire
    @item.update(retire: true)
    redirect_to @category
  end

  def resume
    @item.update(retire: false)
    redirect_to @category
  end

  private

  def post_params
    params.require(:item).permit(:title, :description, :price, :avatar, :retire, :quantity)
  end

  def find_category
    session[:return_to] ||= request.referer
    @category = Category.find(params[:category_id])
  rescue ActiveRecord::RecordNotFound
    render '/layouts/record_not_found'
  end

  def find_item
    @item = Item.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render '/layouts/record_not_found'
  end

  def belongs_to_entity
    redirect_to @category, notice: 'Can not  Destroy because this is belongs to an order You Just Retire This Item'
  end
end
