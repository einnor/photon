class CreateLoans < ActiveRecord::Migration
  def change
    create_table :loans do |t|
      t.float :loan_amount_requested
      t.integer :repay_period_in_months
      t.float :interest_rate_pa
      t.string :loan_interest_method
      t.float :monthly_installments
      t.float :repay_amount
      t.string :loan_status
      t.date :installment_repay_deadline
      t.references :member, index: true

      t.timestamps
    end
  end
end
