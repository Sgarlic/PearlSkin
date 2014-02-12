class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :item_english
      t.string :item_chinese
      t.integer :brand_id
      t.integer :subcategory_id
      t.string :price

      t.timestamps
    end
    add_index :items, :item_english
    add_index :items, :item_chinese
  end
end
