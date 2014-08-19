class AddFieldsToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :number, :string
    add_column :messages, :cost, :string
    add_column :messages, :status, :string
    add_column :messages, :msg_id, :string
  end
end
