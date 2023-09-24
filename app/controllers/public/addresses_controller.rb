class Public::AddressesController < ApplicationController
  def index
    @address = Address.new
    @addresses = Address.all
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      flash[:success] = "配送先の登録が完了しました"
      redirect_to addresses_path
    else
      flash[:danger] = "配送先の内容用に不備があります"
      redirect_to addresses_path
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      flash[:success] = "配送先を保存しました"
      redirect_to addresses_path
    else
      flash[:danger] = "配送先の内容用に不備があります"
      redirect_to addresses_path
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.customer_id = current_customer.id
    @address.destroy
    flash[:success] = "配送先を削除しました"
    redirect_to addresses_path
  end

  private

  def address_params
    params.require(:address).permit(:address, :zip_code, :name)
  end
end
