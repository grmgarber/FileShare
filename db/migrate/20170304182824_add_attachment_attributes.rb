class AddAttachmentAttributes < ActiveRecord::Migration
  def change
    add_column :uploads, :file_name, :string
    add_column :uploads, :file_size, :integer
  end
end
