class ItemsController < ApplicationController
  before_action do
    @category=Category.find(params[:category_id])
  end

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
    @item=@category.items.new(post_params)
    @item.categories_items.build(category_id:@category.id)
    @item.user_id = current_user.id
    if @item.save
      redirect_to category_path(@category)
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
