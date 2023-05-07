class AddDeliveryDateToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :expected_delivery_date, :date
  end
end
