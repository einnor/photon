class CreateServiceFees < ActiveRecord::Migration
  def change
    create_table :service_fees do |t|
      t.string :payment_type
      t.float :amount
      t.text :description
      t.date :next_payment_due_date
      t.string :service_status,               null: false, default: "PENDING"
      t.string :txn_status,                   null: false, default: "PENDING"
      t.string :pesapal_txn_tracking_id
      t.string :pesapal_merchant_reference
      t.references :chama, index: true

      t.timestamps
    end
  end
end
