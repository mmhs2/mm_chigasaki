class Blog < ApplicationRecord


  validates :title, presence: true
  validates :body, presence: true
  validates :place, presence: true


  belongs_to :place
  belongs_to :user
  attachment :image
  has_many_attached :images

  has_many :blog_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many  :tag_relationships, dependent: :destroy
  has_many  :tags, through: :tag_relationships


  def favorite_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def save_tags(saveblog_tags)
    saveblog_tags.each do |new_name|
    blog_tag = Tag.find_or_create_by(name: new_name)
    self.tags << blog_tag
   end
  end

  def save_tags(saveblog_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - saveblog_tags
    new_tags = saveblog_tags - current_tags

    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name: old_name)
    end

    new_tags.each do |new_name|
      blog_tag = Tag.find_or_create_by(name: new_name)
      self.tags << blog_tag
    end
  end

  def self.search(search)
    if search != ""
      Blog.where(['title LIKE(?) OR body LIKE(?)', "%#{search}%", "%#{search}%"])
    else
      Blog.includes(:user).order('created_at DESC')
    end
  end


end