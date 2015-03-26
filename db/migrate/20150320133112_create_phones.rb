class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.integer :meet_id
      t.string :phone_number
      t.string :name
      t.boolean :auto_join
      t.boolean :admin
    end

    add_index :phones, :phone_number, unique: true

  end
end
