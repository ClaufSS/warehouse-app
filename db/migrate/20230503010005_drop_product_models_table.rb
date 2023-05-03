class DropProductModelsTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :product_models
  end
end
