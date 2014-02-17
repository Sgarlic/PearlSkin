class AddImageToItems < ActiveRecord::Migration
  def change
    add_column :items, :image, :binary
    add_column :items, :filename, :string
    add_column :items, :content_type, :string
  end
end
