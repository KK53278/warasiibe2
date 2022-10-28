class Product < ApplicationRecord
  has_many_attached :images
  belongs_to :customer
  has_many :favorites, dependent: :destroy
  has_many :favorited_customers, through: :favorites, source: :customer
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :product_name, presence: true
  validates :caption, presence: true

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

  def create_notification_like!(current_customer)
    # すでに「いいね」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and product_id = ? and action = ? ", current_customer.id, customer_id, id, 'favorite'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_customer.active_notifications.new(
        product_id: id,
        visited_id: customer_id,
        action: 'favorite'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_comment!(current_customer, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:customer_id).where(product_id: id).where.not(customer_id: current_customer.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_customer, comment_id, temp_id['customer_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_customer, comment_id, customer_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_customer, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_customer.active_notifications.new(
      product_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
  
end
