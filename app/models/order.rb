class Order < ApplicationRecord
  belongs_to :customer
  has_many :ordered_products
  enum payment: { credit_card: 0, transfer: 1 }
   def address_display
  '〒' + postal_code + ' ' + address + ' ' + name
   end
end
