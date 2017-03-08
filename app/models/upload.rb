class Upload < ActiveRecord::Base

  belongs_to :user
  has_many :grants

  has_attached_file :upl_file, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"

  validates_attachment :upl_file, presence: true,
                       content_type: {content_type: [/\Aimage\/.*\z/, 'application/pdf']},
                       size: { in: 1..3000.kilobytes}

  validates :description, presence: true, length: {within: 1..50}


  def self.all_viewable_by(user)

    includes(:grants).
    where(
      ['uploads.user_id = :uid
           OR grants.upload_id = uploads.id and grants.user_id = :uid', uid: user.id]).
    references('grants').
    order('upl_file_updated_at desc')

  end

end
