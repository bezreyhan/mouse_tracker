class AddWindowWidthToInteractions < ActiveRecord::Migration
  def change
    add_column :interactions, :window_width, :integer
  end
end
