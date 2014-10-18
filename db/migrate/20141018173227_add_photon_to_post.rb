class AddPhotonToPost < ActiveRecord::Migration
  def change
    add_column :posts, :photon, :string
  end
end
