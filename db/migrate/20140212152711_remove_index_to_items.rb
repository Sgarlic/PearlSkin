class RemoveIndexToItems < ActiveRecord::Migration
  def change
  	remove_index :items, :item_english
  	remove_index :items, :item_chinese
  	add_index :items, :item_english
    add_index :items, :item_chinese
  end
end
