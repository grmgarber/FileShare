# Grant associates an upload with a grantee user allowed to view the upload
# Grant can be created only the the user owning the upload
class Grant < ActiveRecord::Base
  belongs_to :upload
  belongs_to :user   # grantee user, not the owner.  owner is accessed via grant.upload.user

  validates :upload_id, presence: true
  validates :user_id, presence: true
  validates :user_id, uniqueness: {scope: :upload_id, message: 'Duplicate grant not allowed, user already has access'}
end
