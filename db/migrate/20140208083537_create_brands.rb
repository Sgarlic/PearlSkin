class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :brand_chinese
      t.string :brand_english
      t.integer :country_id

      t.timestamps
    end
    add_index :brands, :brand_chinese, unique: true
    add_index :brands, :brand_english, unique: true
    add_index :brands, [:brand_chinese, :brand_english], unique: true
  end
end
