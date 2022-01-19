class FavoritesController < ApplicationController
  before_action :authenticate_user!
  
 def create
   blog = Blog.find(params[:blog_id])
   favorite = current_user.favorites.new(blog_id: blog.id)
   favorite.save
   redirect_to blog_path(blog)
 end
  
 def destroy
   blog = Blog.find(params[:blog_id])
   favorite = current_user.favorites.new(blog_id: blog.id)
   favorite.destroy
   redirect_to blog_path(blog)
 end
  
end
