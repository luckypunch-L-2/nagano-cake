class Admin::CustomersController < ApplicationController
    def index
        @customers = Customer.all.page(params[:page])
    end

    def show
        @customer = Customer.find(params[:id])
        @customers = Customer.all.page(params[:page])
    end

    def edit
        @customer = Customer.find(params[:id])
    end

    def update
        @customer = Customer.find(params[:id])
        @customer.update(customer_params)
        flash[:notice] = "会員情報を編集しました"
        redirect_to admin_customer_path
    end

    private
    def customer_params
        params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :zip_code, :address, :telephone_number, :email, :is_deleted)
    end
end
