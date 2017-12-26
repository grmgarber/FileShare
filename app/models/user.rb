# User represents a human user of the system
class User < ActiveRecord::Base
  MORE_AVAILABLE = '... more available ...'.freeze

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable

  has_many :uploads
  has_many :grants # these are grants given TO the user. Do not care about those
  # given BY the user

  # Find emails of all users whose ID are NOT <user_id> and NOT any of the
  # current viewers of <upload_id>
  # and whose email address contains <term> substring
  def self.potential_grantee_emails(user_id, upload_id, term: '', limit: 30)
    grantee_ids = grantee_user_ids(upload_id)
    q = User.where.not(id: user_id)
    q = q.where('id NOT IN (?)', grantee_ids) unless grantee_ids.empty?
    q = q.where('email LIKE ?', "%#{term}%") unless term.blank?
    q = q.limit(limit + 1)
    res = q.pluck(:email)
    res[-1] = MORE_AVAILABLE if res.size > limit
    res
  end

  # Returns user ids of grantees of the upload identified by the argument
  def self.grantee_user_ids(upload_id)
    Grant.where(upload_id: upload_id).pluck(:user_id)
  end
end

