class Setting < ActiveRecord::Base
  belongs_to :chama

  # Enforce validations on fields
  validates :remittance_deadline, presence: true
  validates :warning_days_before_deadline, presence: true
  validates :remittance_reminder_sms, presence: true
  validates :penalty_reminder_sms, presence: true
  validates :penalty_type, presence: true
  validates :penalty_amount, presence: true
  validates :chama_id, presence: true
  validates :penalty_repay_periods_in_days, presence: true

  validates_numericality_of :warning_days_before_deadline, :greater_than_or_equal_to => 1
  validates_numericality_of :penalty_amount, :greater_than_or_equal_to => 1
  validates_numericality_of :penalty_repay_periods_in_days, :greater_than_or_equal_to => 1
end
