class Supplier < ApplicationRecord
  validates :corporate_name, :brand_name, :registration_number, :full_address, :city, :state, :email, presence: true
  validates :registration_number, uniqueness: true
  validates_format_of :registration_number, with: /\A\d{14}\z/, message: 'Deve fornecer 14 números'

  has_many :product_models
end
