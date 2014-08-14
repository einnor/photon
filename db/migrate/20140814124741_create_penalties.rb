class CreatePenalties < ActiveRecord::Migration
  def change
    create_table :penalties do |t|
      t.string :penalty_type
      t.float :amount
      t.date :due_date
      t.string :penalty_status
      t.references :member, index: true

      t.timestamps
    end
  end
end
