class AddUrlToInteractions < ActiveRecord::Migration
  def change
    add_column :interactions, :url, :text
  end
end
