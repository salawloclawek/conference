class CreateMeets < ActiveRecord::Migration
  def change
    create_table :meets do |t|
      t.string :name
      t.string :phone_number
      t.string :asterisk_user_profile
      t.string :sip_number
      t.string :web_pin
    end
  end
end
