class AddBodyHeightToInteractions < ActiveRecord::Migration
  def change
    add_column :interactions, :body_height, :integer
  end
end
