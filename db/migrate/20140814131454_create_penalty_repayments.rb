class CreatePenaltyRepayments < ActiveRecord::Migration
  def change
    create_table :penalty_repayments do |t|
      t.float :amount
      t.references :penalty, index: true

      t.timestamps
    end
  end
end
