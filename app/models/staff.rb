class Staff < ApplicationRecord
  devise :database_authenticatable,
         :recoverable,
         :rememberable,
         :validatable

  include DeviseTokenAuth::Concerns::User
end
