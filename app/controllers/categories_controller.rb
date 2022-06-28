# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :initialize_session
  before_action :load_cart
  before_action only: %i[edit show update] do
    @category = Category.find(params[:id])
  end
  layout 'dinnerdash'

  def index
    @categories = Category.all
  end

  def show
    @categories_items = CategoriesItem.where(category_id: @category.id)
    @items = @categories_items.collect { |detail| Item.where(id: detail.item_id) }.flatten
  end

  def edit
    authorize @category
  end

  def new
    @category = Category.new
    authorize @category
  end

  def create
    @category = Category.new(post_params)
    @category.user = current_user
    authorize @category
    if @category.save
      redirect_to @category, notice: 'Category has been created Successfully'

    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize @category
    if @category.update(post_params)
      redirect_to @category, notice: "Category Is Updated Successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if CategoriesItem.include?(category_id: params[:id])
      redirect_to root_path, notice: 'hwllo'
    else
      Category.destroy(params[:id])
      redirect_to root_path
    end
  end

  private

  def post_params
    params.require(:category).permit(:name, :avatar)
  end
end
