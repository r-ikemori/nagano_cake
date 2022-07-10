class Public::HomesController < ApplicationController
  before_action :authenticate_customer!, except: [:top, :about]
  def top
    @items = Item.all
    #@items = Item.limit(4).order(" created_at DESC ")
  end

  def about
  end
end
