require_relative '20170304182824_add_attachment_attributes.rb'

class FixUploads < ActiveRecord::Migration
  def change
    revert AddAttachmentAttributes
  end
end
