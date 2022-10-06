class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :product_name
      t.text :caption
      t.integer :customer_id
      t.timestamps
    end
  end
end
