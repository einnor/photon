class CreateWithdrawals < ActiveRecord::Migration
  def change
    create_table :withdrawals do |t|
      t.float :amount
      t.text :description
      t.references :member, index: true

      t.timestamps
    end
  end
end
