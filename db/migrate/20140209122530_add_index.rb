class AddIndex < ActiveRecord::Migration
  def change
  end
  add_index :subcategories, :step
  add_index :categories, :step, unique: true
end
