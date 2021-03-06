class ImageFile < ActiveRecord::Base
  #has_attached_file :image, url: "/img/:hash.:extension",	hash_secret: "longSecretString"
  
  belongs_to :work
  
  has_attached_file :image, styles: {
    thumb: '200x200>',
    square: '300x300#',
    medium: '768x768>'
  }

  # File vaildations
  validates :image, presence: true
  validates_attachment_content_type :image, content_type: ["image/jpeg", "image/jpg", "image/png"], 
                    :message => 'File must be image'
  validates_attachment_size :image, :in => 0..5.megabytes

  include Rails.application.routes.url_helpers

#  def to_jq_image
#    {
#      "name" => read_attribute(:image_file_name),
#      "size" => read_attribute(:image_file_size),
#      "url" => image.url(:original),
#      "id" => self.id,
#      "delete_url" => image_file_path(self),
#      "delete_type" => "DELETE" 
#    }
#  end
end
