class RenameTypeColumnToChamaTypeInChama < ActiveRecord::Migration
  def change
  	rename_column :chamas, :type, :chama_type
  end
end
