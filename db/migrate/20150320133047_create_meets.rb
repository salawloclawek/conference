class CreateMeets < ActiveRecord::Migration
  def change
    create_table :meets do |t|
      t.string :identifier
      t.string :name
    end
  end
end
