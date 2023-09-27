class Public::HomesController < ApplicationController
  def top
    @items = Item.order('id DESC').limit(4)
    @genres = Genre.all
    @genred_items = Item.where(genre_id: params[:genre_id])
  end

  def about
  end
end
