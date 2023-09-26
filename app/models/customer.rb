class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def active_for_authentication?
    super && (is_deleted == false)
  end

  has_many :addresses, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :cart_items, dependent: :destroy


  
  #validates :address, format: { with: /\A\d{7}\z/ }
  #validates :telephone_number, format: { with: /\A\d{10,11}\z/ }
  #validates :first_name, /^[ぁ-んァ-ヶー一-龠]+$/

  

end
