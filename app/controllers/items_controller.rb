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
      redirect_to @category
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def add_to_cart
      id = params[:id] #receving item id
      if session[:cart].include?(id)
        redirect_to category_path(params[:category_id])
      else
        session[:cart][id]=1
      end
       redirect_to category_path(params[:category_id])
  end
  def increase_item_qty
   id = params[:id] #receving item id
   if session[:cart].include?(id)
    session[:cart][id]+=1
   end
  end
  def remove_from_cart
    id = params[:id]
    session[:cart].delete(id)
    redirect_to category_path(params[:category_id])
  end

  def decrease_item_qty
    byebug
    id = params[:id] #receving item id
    if session[:cart].include?(id)
      session[:cart][id]-=1
    end
  end
  private

  def post_params
    params.require(:item).permit(:title, :description, :price, :avatar, :retire, :quantity)
  end
end

