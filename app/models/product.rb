class Product < ApplicationRecord
  has_many_attached :images
  belongs_to :customer
  has_many :favorites, dependent: :destroy

  def get_images
    unless images.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      # self.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'event_default.png')), filename: 'default-image.png', content_type: 'image/png')
      images.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpg')
    else
      images
    end
  end

  def favorited_by?(customer)
    favorites.where(customer_id: customer.id).exists?
  end
end
