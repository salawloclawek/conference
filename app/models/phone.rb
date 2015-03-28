class Phone < ActiveRecord::Base

  scope :phone_number, ->(phone_number) { where(phone_number: phone_number) }

  scope :admin, -> { where(admin: true) }
  scope :participant, -> { where(admin: false) }

  belongs_to :meet
  has_many :key_maps, dependent: :destroy

  accepts_nested_attributes_for :key_maps

  validates :name, presence: true
  validates :phone_number, presence: true, numericality: { only_integer: true }, length: { is: 9, unless: :admin }, uniqueness: true

  before_create :set_admin


  def admin?
    admin
  end

  def participant?
    !admin
  end

  def initialize_key_maps
    for i in 1..4 do
      self.key_maps.build(
        digit: i
      )
    end
  end

  def to_param
    phone_number
  end

  protected

  def set_admin
    if admin.nil?
      self.admin = false
    end
    true
  end

end
