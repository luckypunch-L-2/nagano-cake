class Admin::HomesController < ApplicationController
  def top
    @order = Order.all
    @orders = Order.all.page(params[:page]).per(10)
  end
end
