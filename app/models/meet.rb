class Meet < ActiveRecord::Base

  scope :phone_number, ->(phone_number) { where(phone_number: phone_number) }
  scope :web_pin, ->(web_pin) { where(web_pin: web_pin) }
  scope :token, ->(token) { where(token: token) }
  scope :sip_number, ->(sip_number) { where(sip_number: sip_number) }

  has_many :phones

  before_create :create_token

  def to_param
    phone_number
  end

  def users(reload=false)
    if reload
      @users = MeetsWrapper.users(self)
    else
      @users ||= MeetsWrapper.users(self)
    end
  end

  protected

  def create_token
    self.token = SecureRandom.hex
  end

end
