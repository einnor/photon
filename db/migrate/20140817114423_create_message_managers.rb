class CreateMessageManagers < ActiveRecord::Migration
  def change
    create_table :message_managers do |t|
      t.integer :sms_balance
      t.references :chama, index: true

      t.timestamps
    end
  end
end
