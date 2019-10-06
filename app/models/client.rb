class Client < ApplicationRecord
  PASSWORD_LENGTH = 20

  devise :database_authenticatable,
         :recoverable,
         :rememberable,
         :validatable

  include DeviseTokenAuth::Concerns::User

  has_many :interactions
  has_many :organizations, through: :interactions, dependent: :destroy

  validates :fullname, presence: true, length: { minimum: 5 }
  validates :phone, presence: true,
                    numericality: { only_integer: true },
                    uniqueness: { case_sensitive: false }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  before_validation :set_password, unless: :persisted?

  def reset_password!
    set_password
  end

  private

  def set_password
    self.password = Devise.friendly_token.first(PASSWORD_LENGTH)
  end
end
