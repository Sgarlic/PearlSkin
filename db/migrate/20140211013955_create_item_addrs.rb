class CreateItemAddrs < ActiveRecord::Migration
  def change
    create_table :item_addrs do |t|
      t.string :link_addr
      t.string :description
      t.integer :item_id

      t.timestamps
    end
  end
end
