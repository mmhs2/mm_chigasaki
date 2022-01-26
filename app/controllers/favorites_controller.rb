class FavoritesController < ApplicationController
  before_action :set_post

  def create
    @favorite = Favorite.create(user_id: current_user.id, blog_id: @blog.id)
    @favorite.save
  end

  def destroy
    @favorite = Favorite.find_by(user_id: current_user.id, blog_id: @blog.id)
    @favorite.destroy
  end

  private
  def set_post
    @blog = Blog.find(params[:blog_id])
  end
  
end
