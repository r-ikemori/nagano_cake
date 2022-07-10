class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!, except: [:top, :about]
  def new
    @order = Order.new
  end
  def confirm
    @total = 0
    @customer = current_customer
    @cart_items = @customer.cart_items
    @order = Order.new(order_params)
    if params[:order][:address_number] == "0"
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.first_name + current_customer.last_name
    elsif params[:order][:address_number] == "1"
    @address = Address.find(params[:order][:address_id])
    @order.postal_code = @address.postal_code
    @order.address = @address.address
    @order.name = @address.name
    else
      #処理なし
    end
  end
  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.shipping_cost = 800
    @order.save
    @customer = current_customer
    @cart_item = @customer.cart_items
    @cart_item.each do |cart_item|
      @ordered_products = OrderedProduct.new
        @ordered_products.price = cart_item.item.price
        @ordered_products.amount = cart_item.amount
        @ordered_products.order_id = @order.id
        @ordered_products.item_id = cart_item.item_id
    @ordered_products.save
    end
    current_customer.cart_items.destroy_all
    redirect_to orders_completion_path
  end
  def index
    @customer = current_customer
    @orders = @customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_status = ["入金待ち", "入金確認", "製作中", "発送準備中", "発送済み"]
  end

  def completion
  end

  private

  def order_params
    params.require(:order).permit(:payment, :postal_code, :address, :name, :total_payment)
  end

end
