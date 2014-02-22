class CreateUseds < ActiveRecord::Migration
  def change
    create_table :useds do |t|
      t.integer :user_id
      t.integer :item_id

      t.timestamps
    end
    add_index :useds, :user_id
    add_index :useds, :item_id
    add_index :useds, [:user_id, :item_id], unique:true
  end
end
