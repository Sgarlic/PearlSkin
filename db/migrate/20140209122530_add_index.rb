class AddIndex < ActiveRecord::Migration
  def change
  end
  add_index :subcategories, :step, unique: true
  add_index :categories, :step, unique: true
end
