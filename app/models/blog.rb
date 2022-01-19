class Blog < ApplicationRecord

  validates :image, presence: true
  validates :title, presence: true
  validates :category, presence: true
  validates :body, presence: true

  belongs_to :user
  attachment :image
  has_many :blog_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_tags,dependent: :destroy
  has_many :tags,through: :post_tags

  def favorite_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end