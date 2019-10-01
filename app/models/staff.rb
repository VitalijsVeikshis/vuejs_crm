class Staff < ApplicationRecord
  PASSWORD_LENGTH = 20

  devise :database_authenticatable,
         :recoverable,
         :rememberable,
         :validatable

  include DeviseTokenAuth::Concerns::User

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  before_validation :set_password, unless: :persisted?

  private

  def set_password
    self.password = Devise.friendly_token.first(PASSWORD_LENGTH)
  end
end
