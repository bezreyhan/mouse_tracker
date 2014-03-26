class RemoveTimeFromInteractions < ActiveRecord::Migration
  def change
    remove_column :interactions, :time, :string
  end
end
