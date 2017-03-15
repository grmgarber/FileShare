class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :uploads
  has_many :grants    # these are grants given TO the user. Do not care about those given BY the user

  # Those created by the user plus those granted by other users

  # Find emails of all users whose ID are NOT <user_id> and NOT any of the current viewers of <upload_id>
  #  and whose email address contains <term> substring
  def self.potential_grantee_emails(user_id, upload_id,term)
    grantee_user_ids  = Grant.where(upload_id: upload_id).select('user_id').map(&:user_id)
    q = User.where.not(id: user_id)
    q = q.where("id NOT IN (?)", grantee_user_ids)   unless grantee_user_ids.empty?
    q = q.where('email LIKE ?', "%#{term}%")
    q.select('email').map(&:email)
  end

end

