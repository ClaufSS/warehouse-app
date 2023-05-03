class CreateProductModels < ActiveRecord::Migration[7.0]
  def change
    create_table :product_models do |t|
      t.string :name
      t.float :weight
      t.float :width
      t.float :height
      t.float :depth
      t.string :sku
      t.references :supplier, null: false, foreign_key: true

      t.timestamps
    end
  end
end
