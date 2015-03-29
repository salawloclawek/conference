class Meet < ActiveRecord::Base

  scope :phone_number, ->(phone_number) { where(phone_number: phone_number) }
  scope :web_pin, ->(web_pin) { where(web_pin: web_pin) }
  scope :token, ->(token) { where(token: token) }
  scope :sip_number, ->(sip_number) { where(sip_number: sip_number) }
  scope :active, -> { where(active: true) }

  belongs_to :admin, class_name: 'Phone'
  has_many :phones

  validates :name, presence: true

  validates :sip_number, presence: true, numericality: { only_integer: true }, length: { is: 9 }, uniqueness: true
  validates :phone_number, presence: true, numericality: { only_integer: true }, length: { is: 3 }, uniqueness: true
  validates :web_pin, presence: true, length: { is: 4 }
  validates :pin, presence: true, numericality: { only_integer: true }, length: { is: 4 }
  validates :admin_id, presence: true

  before_create :create_token
  before_create :set_active

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

  def set_active
    if active.nil?
      self.active = true
    end
    true
  end
end
