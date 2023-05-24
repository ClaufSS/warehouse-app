class ProductModel < ApplicationRecord
  belongs_to :supplier
  has_many :order_items
  
  validates :name, :weight, :width, :height, :depth, :sku, presence: true
  validates :weight, :width, :height, :depth, comparison: {greater_than: 0}
  validates :sku, length: {is: 20}
  validates :sku, uniqueness: true
end
