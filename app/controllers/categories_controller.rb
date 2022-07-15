# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :initialize_session
  before_action :load_cart
  before_action :find_category, only: %i[edit show update destroy]
  before_action :authorize_category, except: %i[index show]
  def index
    @categories = Category.all
  end

  def show
    @items = @category.items
  end

  def edit; end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(post_params)
    @category.user = current_user
    Category.transaction do
      unless @category.avatar.attached?
        @category.avatar.attach(io: File.open(Rails.root.join('app/assets/images/no_img.jpg')), filename: 'no_img.jpg')
      end
      if @category.save
        redirect_to @category, success: 'CATEGORY HAS BEEN CREATED SUCCESSFULLY'
      else
        render :new, danger: 'CATEGORY HAS NOT BEEN CREATED'
      end
    end
  end

  def update
    if @category.update(post_params)
      redirect_to @category, success: 'CATEGORY HAS BEEN UPDATED SUCCESSFULLY'
    else
      render :edit, danger: 'CATEGORY HAS NOT BEEN UPDATED'
    end
  end

  def destroy
    if CategoriesItem.exists?(category_id: @category.id)
      redirect_to root_path, danger: 'CATEGORY CAN NOT BE DESTROY, IT HAS MANY ITEMS'
    else
      @category.destroy
      redirect_to root_path, success: 'CATEGORY CAN NOT BE DESTROY, IT HAS MANY ITEMS'
    end
  end

  private

  def post_params
    params.require(:category).permit(:name, :avatar)
  end

  def find_category
    @category = Category.find(params[:id])
  end

  def authorize_category
    authorize Category
  end
end
