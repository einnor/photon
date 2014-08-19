class RenameMemberIdInWithdrawalToChamaId < ActiveRecord::Migration
  def up
    remove_column :withdrawals, :member_id
    add_column :withdrawals, :chama_id, :integer
  end

  def down
    add_column :withdrawals, :member_id, :integer
    remove_column :withdrawals, :chama_id
  end
end
