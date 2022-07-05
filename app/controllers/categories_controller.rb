# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :initialize_session
  before_action :load_cart
  before_action only: %i[edit show update] do
    @category = Category.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render '/layouts/record_not_found'
  end
  def index
    @categories = Category.all
  end

  def show
    @items = @category.items
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
    @category.avatar.attach(io: File.open(Rails.root.join('app/assets/images/no_img.jpg')), filename: 'no_img.jpg') unless @category.avatar.attached?
    if @category.save
      redirect_to @category, notice: 'CATEGORY HAS BEEN CREATED SUCCESSFULLY'

    else
      render :new, notice: 'CATEGORY HAS NOT BEEN CREATED'
    end
  end

  def update
    authorize @category
    if @category.update(post_params)
      redirect_to @category, notice: 'CATEGORY HAS BEEN UPDATED SUCCESSFULLY'
    else
      render :edit, notice: 'CATEGORY HAS NOT BEEN UPDATED'
    end
  end

  def destroy
    if CategoriesItem.find_by(category_id: params[:id])
      redirect_to root_path, notice: 'CATEGORY CAN NOT BE DESTROY, IT HAS MANY ITEMS'
    else
      Category.destroy(params[:id])
      redirect_to root_path, notice: 'CATEGORY HAS BEEN DESTROYED SUCCESSFULLY'
    end
  end

  private

  def post_params
    params.require(:category).permit(:name, :avatar)
  end
end
