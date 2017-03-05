class AddAttmAttributesToUploads < ActiveRecord::Migration
  def change
    add_attachment :uploads, :upl_file
  end
end
