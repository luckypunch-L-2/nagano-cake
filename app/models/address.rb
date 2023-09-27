class Address < ApplicationRecord
  VALID_POSTCODE_REGEX = /\A\d{7}$\z/

  belongs_to :customer

  def address_and_zip_code_and_name
    "〒#{self.address}  #{self.zip_code}  #{self.name}"
  end

  validates :address, presence: true, format: { with: VALID_POSTCODE_REGEX }
  validates :zip_code, presence: true, length: { in: 1..48 }
  validates :name, presence: true, length: { in: 1..32 }

end
