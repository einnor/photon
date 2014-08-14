class CreateLoanRepayments < ActiveRecord::Migration
  def change
    create_table :loan_repayments do |t|
      t.float :amount
      t.references :loan, index: true

      t.timestamps
    end
  end
end
