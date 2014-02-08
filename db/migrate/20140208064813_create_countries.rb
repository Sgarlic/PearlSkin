class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :country_name

      t.timestamps
    end
    add_index :countries, :country_name
  end
end
