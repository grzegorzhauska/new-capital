class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, :last_name, :phone_number, presence: true
  phony_normalize :phone_number
  validates :phone_number, phony_plausible: true

  after_create :create_personal_account

  enum phone_number_status: %i(phone_number_not_verified
                               phone_number_verified)
  has_one :personal_account, dependent: :destroy
  has_many :companies

  def phone_number=(value)
    old_formated = phone_number
    super
    self.phone_number_status =
      :phone_number_not_verified if phone_number != old_formated
  end

  def phone_number(formated = true)
    formated ? super() : super().gsub(/\D/, '')
  end

  # TODO: Max 3 tries
  def phone_number_verify!(code)
    if phone_number_code && (phone_number_code == code)
      phone_number_verified!
      true
    else
      false
    end
  end

  def verified?
    phone_number_verified?
  end

  # TODO: Constraint in time
  def send_verification_code
    return false unless self.update_attribute(:phone_number_code,
                                              1000 + rand(8999))

    nexmo = Nexmo::Client.new(key: Figaro.env.nexmo_key,
                              secret: Figaro.env.nexmo_secret)

    response = nexmo.send_message({
      from: 'AppName',
      to: phone_number(false),
      text: "Verification code for AppName is: #{phone_number_code}"
    })

    response[:status] == 0
  end

end
