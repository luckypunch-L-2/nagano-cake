class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!, only: [:new, :confirm, :create, :index, :show, :complete]

  def new
    @order = Order.new
  end

  def confirm
    @cart_items = current_customer.cart_items.all
    @postage = 800
    @selected_payment_method = params[:order][:payment_method]

    ary = []
    @cart_items.each do |cart_item|

      ary << cart_item.item.add_tax_price * cart_item.amount

    end
    @cart_items_price = ary.sum

    @total_payment = @postage + @cart_items_price
    @address_type = params[:order][:address_type]
    case @address_type
    when "customer_address"
      @selected_address = current_customer.zip_code + " " + current_customer.address + " " + current_customer.last_name + current_customer.first_name
    when "registered_address"
      unless params[:order][:registered_address_id] == " "
        selected = Address.find(params[:order][:registered_address_id])
        @selected_address = selected.zip_code + " " + selected.address + " " + selected.name
      else
        render.new
      end
    when "new_address"
      unless params[:order][:new_zip_code] == " " && params[:order][:new_address] == " " && params[:order][:new_name] == " "
        @selected_address = params[:order][:new_zip_code] + " " + params[:order][:new_address] + " " + params[:order][:new_name]
      else
        render.new
      end
    end
  end

  def create
    @order = Order.new
    @order.customer_id = current_customer.id
    @order.postage = 800
    @cart_items = CartItem.where(customer_id: current_customer.id)

    ary = []
    @cart_items.each do |cart_item|

      ary << cart_item.item.add_tax_price * cart_item.amount

    end
    @cart_items_price = ary.sum
    @order.total_payment = @order.postage + @cart_items_price
    @order.payment_method = params[:order][:payment_method]
    if @order.payment_method == "credit_card"
      @order.status = 1
    else
      @order.status = 0
    end
  address_type = params[:order][:address_type]
  case address_type
  when "customer_address"
    @order.zip_code = current_customer.zip_code
    @order.address = current_customer.address
    @order.name = current_customer.last_name + current_customer.first_name
  when "registered_address"
    Address.find(params[:order][:registered_address_id])
    selected = Address.find(params[:order][:registered_address_id])
    @order.zip_code = selected.zip_code
    @order.address = selected.address
    @order.name = selected.name
  when "new_address"
    @order.zip_code = params[:order][:new_zip_code]
    @order.address = params[:order][:new_address]
    @order.name = params[:order][:new_name]
  end

  if @order.save
    if @order.status == 0
      @cart_items.each do |cart_item|
        OrderDetail.create!(order_id: @order.id, item_id: cart_item.item.id, price: cart_item.item.price, amount: cart_item.amount, making_status: 0)
      end
    else
      @cart_items.each do |cart_item|
        OrderDetail.create!(order_id: @order.id, item_id: cart_item.item.id, price: cart_item.item.price, amount: cart_item.amount, making_status: 1)
      end
    end
    @cart_items.destroy_all
    redirect_to orders_complete_path
  else
    render.items
  end
  end

  def index
    @orders = Order.where(customer_id: current_customer.id).order(created_at: :desc)
  end

  def show
    @order = Order.find()
    @order_details = @order.order_details
  end

  def complete
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :zip_code, :address, :name)
  end

end
