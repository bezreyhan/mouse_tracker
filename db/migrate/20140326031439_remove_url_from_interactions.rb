class RemoveUrlFromInteractions < ActiveRecord::Migration
  def change
    remove_column :interactions, :url, :text
  end
end
