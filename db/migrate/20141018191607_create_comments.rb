class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.integer :user_id
      t.references :post, index: true

      t.timestamps
    end
  end
end
