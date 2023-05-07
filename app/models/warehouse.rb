class Warehouse < ApplicationRecord
  validates :name, :code, :city, :area, :address, :cep, :description, presence: true
  validates :name, :code, uniqueness: true
  validates_format_of :cep, with: /\A\d{5}-\d{3}\z/, message: "Deve estar no formato 00000-000"

  
  def full_description
    "#{code} - #{name}"
  end
end
