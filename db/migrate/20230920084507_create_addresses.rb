class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.string :admin
      t.string :cart_item
      t.string :customer
      t.string :genre
      t.string :item
      t.string :order
      t.string :order_detail

      t.timestamps
    end
  end
end
