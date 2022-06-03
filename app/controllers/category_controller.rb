class CategoryController < ApplicationController
  def index
    @categories= Category.all
  end
  def show
    @category = Category.find(params[:id])
  end


  def new
     byebug
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
  private

  def post_params
    params.require(:category).permit(:type)
  end

end
