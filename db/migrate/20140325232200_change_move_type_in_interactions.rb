class ChangeMoveTypeInInteractions < ActiveRecord::Migration
  def up 
    change_column :interactions, :move, :text
  end

  def down 
    change_column :interactions, :move, :string
  end
end
