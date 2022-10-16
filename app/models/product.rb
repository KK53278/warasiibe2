class Product < ApplicationRecord
  has_many_attached :images
  belongs_to :customer
  has_many :favorites, dependent: :destroy
  has_many :favorited_customers, through: :favorites, source: :customer
  has_many :comments, dependent: :destroy

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
  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @product = Product.where("product_name LIKE?","#{word}")
    elsif search == "forward_match"
      @product = Product.where("product_name LIKE?","#{word}%")
    elsif search == "backward_match"
      @product = Product.where("product_name LIKE?","%#{word}")
    elsif search == "partial_match"
      @product = Product.where("product_name LIKE?","%#{word}%")
    else
      @product = Product.all
    end
  end
  # いいねランキング
  def self.create_all_ranks
    Product.find(Favorite.group(:product_id).order('count(product_id) desc').limit(3).pluck(:product_id))
  end
end
