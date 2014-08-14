class CreateRemittances < ActiveRecord::Migration
  def change
    create_table :remittances do |t|
      t.float :amount
      t.string :remittance_type
      t.references :member, index: true

      t.timestamps
    end
  end
end
