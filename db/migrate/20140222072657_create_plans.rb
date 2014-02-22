class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.integer :user_id
      t.integer :item_id

      t.timestamps
    end
    add_index :plans, :user_id
    add_index :plans, :item_id
    add_index :plans, [:user_id, :item_id], unique:true
  end
end
