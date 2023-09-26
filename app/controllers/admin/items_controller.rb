class Admin::ItemsController < ApplicationController
  #before_action :authenticate_admin!
  before_action :set_item, only: %i[show edit update]

  def index
    @items = Item.all.page(params[:page]).per(10)
  end

  def new
    @item = Item.new
    @genres = Genre.all
    @genre = Genre.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save

      redirect_to admin_item_path(@item.id),notice: "商品を登録しました。"
    else
      @genres = Genre.all

      render :new
    end
  end



  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    @genres = Genre.all
  end



  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_item_path(@item.id), notice: "商品情報を更新しました。"
    else
      @genres = Genre.all
      render :edit
    end
  end

  def set_item
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:name, :explanation, :price, :image, :is_active, :genre_id)
  end

end