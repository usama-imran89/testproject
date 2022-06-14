class CategoriesController < ApplicationController

  before_action :initialize_session
  before_action :increment_visit_count
  before_action :load_cart

  layout "header"

  def index

    @categories_items= CategoriesItem.all
    @categories=Category.all
    @items=Item.all
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
  def add_to_cart
    id = params[:id]
    if session[:cart].include?(id)
      puts "Hello"
      #session[:cart][id]+=1
    else
      session[:cart][id]=1
    end
    redirect_to category_path(params[:category_id])

  end
  def about

  end
  private

  def post_params
    params.require(:category).permit(:name, :avatar)
  end

  def get_category_item_id

    #  {params[:category_id]:{ "id:"=>params[:id]}}
  end
end
