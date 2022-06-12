class CategoriesController < ApplicationController

  before_action :initialize_session
  before_action :increment_visit_count
  before_action :load_cart
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
    id = params[:id].to_i
    session[:cart]<< id unless session[:cart].include?(id)
    redirect_to category_path(params[:category_id])

  end
  def about

  end
  private

  def post_params
    params.require(:category).permit(:name)
  end
  def initialize_session
    session[:visit_count] ||=0
    session[:cart] ||=[]
  end
  def load_cart
    @cart =Item.find(session[:cart])
  end

  def increment_visit_count
    session[:visit_count]+=1
    @visit_count =session[:visit_count]
  end
  def get_category_item_id

    #  {params[:category_id]:{ "id:"=>params[:id]}}
  end
end
