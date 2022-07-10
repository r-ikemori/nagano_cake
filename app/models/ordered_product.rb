class OrderedProduct < ApplicationRecord
  belongs_to :order
  belongs_to :item
  enum making_status: { "製作不可": 0, "製作待ち": 1,"製作中": 2,"製作完了": 3 }
  def with_tax_price
    (price * 1.1).floor
  end
  def subtotal
    item.with_tax_price * amount
  end
end
