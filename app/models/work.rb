class Work < ActiveRecord::Base

  belongs_to :user
  #has_many :imagefiles

  has_attached_file :image, styles: {
    thumb: '200x200>',
    square: '300x300#',
    medium: '768x768>'
  }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :image, :content_type =>  /^image\/(png|gif|jpeg|jpg)/

  validates :title, :description, :image, presence: true
  
  Paperclip.interpolates :normalized_filename do |attachment, style|
    attachment.instance.normalized_filename
  end
  
  def normalized_filename
    "#{user.username}-#{self.id}"
  end

end
