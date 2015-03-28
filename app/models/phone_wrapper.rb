class PhoneWrapper

  attr_accessor :name, :phone, :phone_object, :identifier_in_conf, :mute_status


  def self.set_participate(params)

    digit = params[:key].to_i
    callerid = MeetsWrapper.slice_caller_id(params[:callerid])

    if digit > 0
      key = "#{callerid}#{digit}"
      Rails.cache.write(key, true, expires_in: 8)
    else
      (1..4).to_a.each do |index|
        key = "#{callerid}#{index}"
        if Rails.cache.read(key)
          Rails.cache.write(key, 'cancel', expires_in: 5)
        end
      end
    end

  end


  def initialize(callerid, identifier_in_conf, mute_status)

    self.identifier_in_conf = identifier_in_conf
    self.mute_status = mute_status

    phone = Phone.phone_number(callerid).first
    if phone.present?
      self.phone_object = phone
      self.phone = phone.phone_number
      self.name = phone.name
    else
      self.phone = callerid
      self.name = callerid
    end

  end

end