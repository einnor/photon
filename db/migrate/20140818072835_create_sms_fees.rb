class CreateSmsFees < ActiveRecord::Migration
  def change
    create_table :sms_fees do |t|
      t.string :package
      t.float :amount
      t.string :txn_status
      t.string :pesapal_txn_tracking_id
      t.string :pesapal_merchant_reference
      t.references :chama, index: true

      t.timestamps
    end
  end
end
