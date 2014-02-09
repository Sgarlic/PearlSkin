class AddStepToSubcategories < ActiveRecord::Migration
  def change
    add_column :subcategories, :step, :integer
  end
end
