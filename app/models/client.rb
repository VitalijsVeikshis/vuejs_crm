class Client < ApplicationRecord
  acts_as_token_authenticatable

  devise :database_authenticatable,
         :recoverable,
         :rememberable,
         :validatable
end
