class Item < ApplicationRecord
  has_one_attached :image
  
  has_many :cart_items, dependent: :destroy
  belongs_to :genre, dependent: :destroy

  def  add_tax_price
    (price * 1.10).round
  end

end
