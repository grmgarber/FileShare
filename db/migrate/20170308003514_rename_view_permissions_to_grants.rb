class RenameViewPermissionsToGrants < ActiveRecord::Migration
  def change
    rename_table :view_permissions, :grants
  end
end
