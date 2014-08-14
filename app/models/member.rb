class Member < ActiveRecord::Base
  belongs_to :chama
  has_many :remittances
  has_many :loans
  has_many :penalties
  has_many :withdrawals

  # Validate Members
  validates :name, presence: true
  validates :phone_number, presence: true
  validates :occupation, presence: true
  validates :national_id_number, presence: true
  validates :phone_number, presence: true
  validates :chama_id, presence: true
end
