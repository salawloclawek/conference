class CreateMeets < ActiveRecord::Migration
  def change
    create_table :meets do |t|
      t.string :name
      t.string :phone_number
      t.string :asterisk_user_profile_pre
      t.string :sip_number
      t.string :web_pin
      t.string :token
    end
  end
end
