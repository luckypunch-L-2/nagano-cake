class Item < ApplicationRecord
  has_one_attached :image

  belongs_to :genre
  has_many :order_details, dependent: :destroy
  has_many :cart_items, dependent: :destroy

  def  add_tax_price
    (price * 1.10).round
  end

end
