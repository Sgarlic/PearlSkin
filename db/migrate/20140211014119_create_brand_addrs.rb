class CreateBrandAddrs < ActiveRecord::Migration
  def change
    create_table :brand_addrs do |t|
      t.string :link_addr
      t.string :description
      t.integer :brand_id

      t.timestamps
    end
  end
end
