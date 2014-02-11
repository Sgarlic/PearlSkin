class AddCharacterToItems < ActiveRecord::Migration
  def change
    add_column :items, :character, :string
  end
end
