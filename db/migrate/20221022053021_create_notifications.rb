class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.references :visitor, foreign_key:{ to_table: :customers }, null: false
      t.references :visited, foreign_key:{ to_table: :customers }, null: false
      t.integer :product_id
      t.integer :comment_id
      t.string :action, default: '', null: false
      t.boolean :checked, default: false, null: false

      t.timestamps
    end

    # add_index :notifications, :visitor_id
    # add_index :notifications, :visited_id
    add_index :notifications, :product_id
    add_index :notifications, :comment_id
  end
end
