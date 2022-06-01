class ItemsController < ApplicationController


  def index
    @items=Item.all
  end


  def show
    @item = Item.find(params[:id])
  end


  def new
    @item=Item.new
  end


  def create
    @item=Item.new(post_params)
    @item.user= current_user
    byebug
    if @item.save
      redirect_to @item
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
