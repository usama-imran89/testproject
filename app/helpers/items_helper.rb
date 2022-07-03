# frozen_string_literal: true

module ItemsHelper
  def find_item_by_params(param)
    id = param # receving item id
  end
  
  def add_to_cart
    if session[:cart].include?(params[:id])
      redirect_to @category
    else
      session[:cart][params[:id]] = 1
    end
    redirect_to session.delete(:return_to), notice: 'ITEM HAS BEEN ADDED'
  end

  def increase_item_qty
    @item = Item.find(params[:id])
    if session[:cart].include?(params[:id])
      if session[:cart][params[:id]] + 1 <= @item.quantity
        session[:cart][params[:id]] += 1
      end
    end
    redirect_to session.delete(:return_to), notice: "YOU ADDED #{session[:cart][params[:id]]} #{Item.find_by(id: params[:id]).title.upcase} IN YOUR CART"
  end

  def remove_from_cart
    session[:cart].delete(params[:id])
    redirect_to session.delete(:return_to), notice: 'ITEM HAS BEEN REMOVED FROM YOUR CART'
  end

  def decrease_item_qty # rubocop:disable Metrics/AbcSize
    if session[:cart].include?(params[:id]) && (session[:cart][params[:id]] - 1) >= 0
      session[:cart][params[:id]] -= 1
    end
    if  session[:cart].include?(params[:id]) && session[:cart][params[:id]].zero?
      session[:cart].delete(params[:id])
    end
    redirect_to session.delete(:return_to), notice: "1 #{Item.find_by(id: params[:id]).title.upcase} HAS BEEN REMOVED FROM CART"
  end
end
