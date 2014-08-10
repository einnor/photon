class CreateChamas < ActiveRecord::Migration
  def change
    create_table :chamas do |t|
      t.string :name
      t.string :description
      t.string :type
      t.integer :approx_no_of_members
      t.references :user, index: true

      t.timestamps
    end
  end
end
