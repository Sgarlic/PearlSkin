class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :item_id
      t.string :content
      t.string :author

      t.timestamps
    end
  end
end
