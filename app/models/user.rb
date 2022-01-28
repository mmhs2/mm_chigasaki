class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :blogs, dependent: :destroy
  has_many :blog_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  attachment :profile_image
  has_many_attached :images

  def already_favorited?(blog)
    self.favorites.exists?(blog_id: blog.id)
  end
  
  
  def self.search(search)
    if search != ""
      User.where(['name LIKE(?)', "%#{search}%"])
    else
      User.includes(:user).order('created_at DESC')
    end
  end
  
  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end

end
