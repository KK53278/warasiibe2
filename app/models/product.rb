class Product < ApplicationRecord
  has_one_attached :image
  belongs_to :customer
  
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      # self.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'event_default.png')), filename: 'default-image.png', content_type: 'image/png')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpg')
    end
    image
  end
  
end
