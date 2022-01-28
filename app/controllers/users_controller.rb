class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @blogs = @user.blogs.page(params[:page]).per(10)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
    
    if params[:user][:image_ids]
      params[:user][:image_ids].each do |image_id|
        image = @user.images.find(image_id)
        image.purge
      end
    end
    
    
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :profile_image ,:caption, images: [] )
  end

end
