class ItemsController < ApplicationController


  def index
    @items=Item.all
  end


  def show
    @item = Item.find(params[:id])
  end


  def new
   @category=Category.find(params[:category_id])
    @item=Item.new

  end


  def create
    @category=Category.find(params[:category_id])
    #@item.user= current_user
    byebug
    @item=@category.items.new(post_params)
    #@item.category=@category
    if @item.save
      redirect_to @category
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])

    if @item.update(post_params)
      redirect_to @item
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:item).permit(:title, :description, :price)
  end
end
