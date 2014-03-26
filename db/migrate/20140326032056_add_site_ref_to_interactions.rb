class AddSiteRefToInteractions < ActiveRecord::Migration
  def change
    add_reference :interactions, :site, index: true
  end
end
