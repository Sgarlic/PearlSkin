class CreateSubcategories < ActiveRecord::Migration
  def change
    create_table :subcategories do |t|
      t.string :name
      t.integer :category_id

      t.timestamps
    end
    add_index :subcategories, [:name, :category_id], unique: true
  end
end
