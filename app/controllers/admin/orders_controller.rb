class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @status = ["製作不可", "製作待ち", "製作中", "製作完了"]
    @order_status = ["入金待ち", "入金確認", "製作中", "発送準備中", "発送済み"]
  end
  def update
   order = Order.find(params[:id])
   order.update(orders_params)
   if order.status == "入金確認"
     order.ordered_products.update(making_status:1)
   end
   redirect_to admin_order_path(order.id)
  end

   private

  def orders_params
    params.require(:order).permit(:status)
  end

end
