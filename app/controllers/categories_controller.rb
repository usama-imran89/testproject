class CategoriesController < ApplicationController
  before_action :initialize_session
  before_action :load_cart
  layout "dinnerdash"
  def index
    @categories=Category.all
  end
  def show
    @category = Category.find(params[:id])
    @categories_items=CategoriesItem.all
    @items=Item.all

  end

  def edit
    @category=Category.find(params[:id])
  end
  def new
    @category=Category.new
  end

  def create
    @category=Category.new(post_params)
    @category.user= current_user
    if @category.save
      redirect_to @category
    else
      render :new, status: :unprocessable_entity
    end
  end
  def update
    @category = Category.find(params[:id])

    if @category.update(post_params)
      redirect_to @category
    else
      render :edit, status: :unprocessable_entity
    end
  end
  private

  def post_params
    params.require(:category).permit(:name, :avatar)
  end

end
