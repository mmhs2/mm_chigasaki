class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @tag_list = Tag.all
    @places = Place.all

    @range = params[:range]

    if @range == "User"
      @users = User.looks(params[:search], params[:word])
    else
      @blogs = Blog.looks(params[:search], params[:word])
    end
  end

end
