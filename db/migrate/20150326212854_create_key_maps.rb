class CreateKeyMaps < ActiveRecord::Migration
  def change
    create_table :key_maps do |t|
      t.integer :phone_id
      t.integer :digit
      t.string  :name
    end
  end
end
