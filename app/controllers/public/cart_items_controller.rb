class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!, except: [:top, :about]
  def index
    @customer = current_customer
    @cart_items = @customer.cart_items
    @total = 0
  end
  def create
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      @cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      @cart_item.amount += cart_item_params[:amount].to_i
      @cart_item.update(amount: @cart_item.amount)
    else
      @cart_item = current_customer.cart_items.new(cart_item_params)
      @cart_item.customer_id = current_customer.id
      @cart_item.save
    end
    redirect_to cart_items_path
  end
  def update
    cart_item = CartItem.find(params[:id])
    cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end
  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end
  def destroy_all
    cart_item = current_customer.cart_items
    cart_item.destroy_all
    redirect_to cart_items_path

  end
  private

  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
  end
end
