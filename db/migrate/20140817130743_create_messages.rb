class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :body
      t.string :recepient
      t.references :message_manager, index: true

      t.timestamps
    end
  end
end
