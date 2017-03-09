class Grant < ActiveRecord::Base
  # grant associates an upload with a grantee user allowed to view the upload
  # grant can be created only the the user owning the upload

  belongs_to :upload
  belongs_to :user   # grantee user,not the owner.  owner is accessed via grant.upload.user

  validates :upload_id, presence: true
  validates :user_id, presence: true


end
