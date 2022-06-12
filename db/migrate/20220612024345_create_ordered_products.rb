class CreateOrderedProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :ordered_products do |t|
      t.integer :price, null: false
      t.integer :amount, null: false
      t.integer :making_status, null: false, default: 0
      t.integer :order_id, null: false
      t.integer :item_id, null: false

      t.timestamps
    end
  end
end
