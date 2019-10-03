class Organization < ApplicationRecord
  ERROR_MESSAGES = {
    INN_12: 'Please use 12 characters',
    INN_10: 'Please use 10 characters'
  }.freeze

  enum form_of_ownership: %w[ИП ООО КФХ АО ПАО ЗАО]

  has_many :equipments, dependent: :destroy

  validates :name, presence: true,
                   uniqueness: { case_sensitive: false }
  validates :form_of_ownership, presence: true
  validates :inn, presence: true,
                  uniqueness: { case_sensitive: false },
                  numericality: { only_integer: true }
  validates :ogrn, presence: true,
                   uniqueness: { case_sensitive: false },
                   length: { is: 13 },
                   numericality: { only_integer: true }
  validate :validate_inn_length

  private

  def validate_inn_length
    errors.add(:inn, ERROR_MESSAGES[:INN_12]) if form_of_ownership == 'ИП' && inn&.length != 12
    errors.add(:inn, ERROR_MESSAGES[:INN_10]) if form_of_ownership != 'ИП' && inn&.length != 10
  end
end
