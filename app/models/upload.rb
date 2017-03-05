class Upload < ActiveRecord::Base
  has_attached_file :upl_file, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"

  validates_attachment :upl_file, presence: true,
                       content_type: {content_type: [/\Aimage\/.*\z/, 'application/pdf']},
                       size: { in: 1..3000.kilobytes}

  validates :description, presence: true, length: {within: 1..50}


end
