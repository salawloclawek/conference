class AddPinActiveToMeets < ActiveRecord::Migration
  def change
    add_column :meets, :pin, :string
    add_column :meets, :active, :boolean
    add_column :meets, :admin_id, :integer
    remove_column :meets, :asterisk_user_profile_pre, :string
  end
end
