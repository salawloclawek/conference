class UserWrapper

  attr_accessor :name, :phone, :identifier_in_conf, :mute_status, :participate


  def self.set_participate(params)
    if params[:key] == '1'
      Rails.cache.write(params[:callerid], true, expires_in: 8)
    else
      if Rails.cache.read(params[:callerid])
        Rails.cache.write(params[:callerid], 'cancel', expires_in: 5)
      else
        Rails.cache.write(params[:callerid], false, expires_in: 5)
      end
    end
  end


  def initialize(identifier, identifier_in_conf, mute_status)

    self.identifier_in_conf = identifier_in_conf
    self.mute_status = mute_status

    phone = Phone.where(identifier: identifier).first
    if phone.present?
      self.phone = phone.identifier
      self.name = phone.user.name
      self.participate = Rails.cache.read(identifier)
    else
      self.phone = identifier
      self.name = identifier
      self.participate = false
    end

  end

end