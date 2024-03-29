class Order < ApplicationRecord
  belongs_to :customer
  has_many :ordered_products
  enum payment: { credit_card: 0, transfer: 1 }
  enum status: { "入金待ち": 0, "入金確認": 1, "製作中": 2, "発送準備中": 3, "発送済み": 4 }
   def address_display
  '〒' + postal_code + ' ' + address + ' ' + name
   end
end
