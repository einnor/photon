class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.date :start
      t.date :end
      t.string :importance
      t.references :chama, index: true

      t.timestamps
    end
  end
end
