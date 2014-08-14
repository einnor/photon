class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name
      t.string :phone_number
      t.string :occupation
      t.string :national_id_number
      t.text :others
      t.references :chama, index: true

      t.timestamps
    end
  end
end
