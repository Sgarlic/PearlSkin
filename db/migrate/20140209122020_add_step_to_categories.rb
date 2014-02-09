class AddStepToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :step, :integer
  end
end
