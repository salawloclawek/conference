class KeyMap < ActiveRecord::Base

  belongs_to :phone

  def participate
    Rails.cache.read("#{phone.phone_number}#{digit}")
  end

end
