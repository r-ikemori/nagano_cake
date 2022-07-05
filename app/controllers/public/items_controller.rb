class Public::ItemsController < ApplicationController
  before_action :authenticate_customer!, except: [:top, :about]
  def index
    @items = Item.page(params[:id])
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end
end
