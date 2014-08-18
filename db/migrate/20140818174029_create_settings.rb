class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.date :remittance_deadline
      t.integer :warning_days_before_deadline
      t.text :remittance_reminder_sms
      t.text :penalty_reminder_sms
      t.string :penalty_type
      t.float :penalty_amount
      t.integer :penalty_repay_periods_in_days
      t.references :chama, index: true

      t.timestamps
    end
  end
end
