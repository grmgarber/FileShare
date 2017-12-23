class AddViewPermissions < ActiveRecord::Migration
  def change
    create_table :view_permissions do |t|
      t.integer :upload_id
      t.integer :user_id      # user_id who's granted permission to view upload_id

      t.timestamps null: false
    end
  end
end
