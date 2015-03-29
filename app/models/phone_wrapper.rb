class PhoneWrapper

  attr_accessor :name, :phone, :phone_object, :identifier_in_conf, :mute_status, :admin


  def self.menu_callback(params)

    digit = params[:key].to_i
    callerid = MeetsWrapper.slice_caller_id(params[:callerid])

    key = "#{callerid}#{digit}"

    if digit == 9
      Rails.cache.write(key, true, expires_in: 3)
    elsif digit == 0
      (1..4).to_a.each do |index|
        key = "#{callerid}#{index}"
        if Rails.cache.read(key)
          Rails.cache.write(key, 'cancel', expires_in: 5)
        end
      end
    elsif Rails.cache.read("#{callerid}9")
      Rails.cache.write("#{callerid}count", digit, expires_in: 60*60*3)
    else
      Rails.cache.write(key, true, expires_in: 8)
    end

  end

  def self.full_identifier(identifier)
    "SIP/#{identifier}"
  end

  def initialize(callerid, identifier_in_conf, mute_status)

    self.identifier_in_conf = identifier_in_conf.slice(4..-1)
    self.mute_status = mute_status

    phone = Phone.phone_number(callerid).first
    if phone.present?
      self.phone_object = phone
      self.phone = phone.phone_number
      self.name = phone.name
      self.admin = phone.admin
    else
      self.phone = callerid
      self.name = callerid
      self.admin = false
    end

  end

  def together_count
    (count = Rails.cache.read("#{phone}count")) ? count.to_s : '1'
  end

end