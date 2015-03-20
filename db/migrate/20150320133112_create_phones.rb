class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.integer :user_id
      t.string :identifier
    end
  end
end
