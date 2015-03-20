class UserWrapper

  attr_accessor :name, :phone, :identifier_in_conf, :mute_status

  def initialize(identifier, identifier_in_conf, mute_status)

    self.identifier_in_conf = identifier_in_conf
    self.mute_status = mute_status

    phone = Phone.where(identifier: identifier).first
    if phone.present?
      self.phone = phone.identifier
      self.name = phone.user.name
    else
      self.phone = identifier
      self.name = identifier
    end

  end

end