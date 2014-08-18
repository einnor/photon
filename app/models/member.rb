class Member < ActiveRecord::Base
  belongs_to :chama
  has_many :remittances, dependent: :destroy
  has_many :loans, dependent: :destroy
  has_many :penalties, dependent: :destroy
  has_many :withdrawals, dependent: :destroy

  # Validate Members
  validates :name, presence: true
  validates :phone_number, presence: true
  validates :occupation, presence: true
  validates :national_id_number, presence: true
  validates :phone_number, presence: true
  validates :chama_id, presence: true
end
