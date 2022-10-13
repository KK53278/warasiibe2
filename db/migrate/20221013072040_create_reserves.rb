class CreateReserves < ActiveRecord::Migration[6.1]
  def change
    create_table :reserves do |t|
      t.integer :zip
      t.string :adress
      t.string :name
      t.string :note
      t.timestamps
    end
  end
end
