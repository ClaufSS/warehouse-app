class Order < ApplicationRecord
  belongs_to :warehouse
  belongs_to :supplier
  belongs_to :user


  validate :date_be_in_future
  before_validation :generate_code

  private

  def date_be_in_future
    if self.expected_delivery_date.present? && self.expected_delivery_date <= Date.today
      errors.add(:expected_delivery_date, "precisa estar no futuro.")
    end
  end

  def generate_code
    self.code = SecureRandom.alphanumeric(10).upcase
  end
end
