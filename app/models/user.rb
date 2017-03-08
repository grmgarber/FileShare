class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :uploads
  has_many :grants    # these are grants given TO the user. Do not care about those given BY the user

  # Those created by the user plus those granted by other users


end
