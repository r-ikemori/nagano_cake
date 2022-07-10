class Admin::OrderedProductsController < ApplicationController
  def update
   order_detail = OrderedProduct.find(params[:id])
   order_detail.update(making_status: params[:ordered_product][:making_status])
   order_count = order_detail.order.ordered_products.count

   order = order_detail.order
   order_details = order.ordered_products
   if order_details.all? {|order_detail| order_detail.making_status == "製作完了"}
      order.update(status:3)
   elsif
      order_details.any? {|order_detail| order_detail.making_status == "製作中"}
      order.update(status:2)
   end

   #order_detail.order.ordered_products.where(making_status: 3).count == order_detail.order.ordered_products.count

   redirect_to admin_order_path(order_detail.order.id)
  end


  private

  def ordered_products_params
    params.require(:ordered_product).permit(:making_status)
  end

end

