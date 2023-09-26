class Public::ItemsController < ApplicationController
before_action :authenticate_customer!, only: [:show]

  def index
    @item = Item.all
    @items = Item.all.page(params[:page]).per(8)
  end

  def show
    @item = Item.find(params[:id])
    @into_cart = CartItem.new
  end


  private

  def item_params
    params.require(:item).permit(:genre_id, :name, :explanation, :image_id, :price)
  end

end
