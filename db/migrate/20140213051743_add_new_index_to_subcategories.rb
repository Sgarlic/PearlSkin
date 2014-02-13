class AddNewIndexToSubcategories < ActiveRecord::Migration
  def change
  	remove_index :subcategories, :step
  	add_index :subcategories, :step
  end
end
