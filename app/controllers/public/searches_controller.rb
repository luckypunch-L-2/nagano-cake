class Public::SearchesController < ApplicationController
  def index
    @genre_id = params[:genre_id]
    @items = Item.where(genre_id: @genre_id)
  end
end