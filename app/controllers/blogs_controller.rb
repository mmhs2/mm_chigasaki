class BlogsController < ApplicationController

  def about
  end

  def index
    @blogs = Blog.page(params[:page]).per(10)
    @tag_list = Tag.all
    @places = Place.all
  end

  def show
    @blog = Blog.find(params[:id])
    @blog_comment = BlogComment.new
    @tag_list=Tag.all
    @places = Place.all
    @place = @blog.place
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = current_user.blogs.build(blog_params)
    tag_list = params[:blog][:tag_ids].split(',')
    if @blog.save
      @blog.save_tags(tag_list)
      flash[:success] = '投稿しました!'
      redirect_to blog_path(@blog.id)
    else
      render :new
    end
  end


  def edit
    @blog = Blog.find(params[:id])
    @tag_list =@blog.tags.pluck(:name).join(",")
  end

  def update
    @blog = Blog.find(params[:id])
    tag_list = params[:blog][:tag_ids].split(',')
    
    if params[:blog][:image_ids]
      params[:blog][:image_ids].each do |image_id|
        image = @blog.images.find(image_id)
        image.purge
      end
    end
    
    if @blog.update_attributes(blog_params)
      @blog.save_tags(tag_list)
      flash[:success] = '投稿を編集しました‼'
      redirect_to blog_path(@blog.id)
    else
     render 'edit'
    end
  end
  
  def destroy
    blog = Blog.find(params[:id])
    blog.destroy
    redirect_to blogs_path
  end

  def search_tag
    @tag_list=Tag.all
    @tag=Tag.find(params[:tag_id])
    @places = Place.all
    @blogs = @tag.blogs.page(params[:page]).per(10)
  end

  def search_place
    @place_list = Place.all
    @tag_list = Tag.all
    @place = Place.find(params[:place_id])
    @places = Place.all
    @blogs = @place.blogs.page(params[:page]).per(10)
  end
  
  def search
    @blogs = Blog.search(params[:keyword]).page(params[:page]).per(10)
    @tag_list = Tag.all
    @places = Place.all
  end
  
  
  
  private

  def blog_params
    params.require(:blog).permit(:title, :place_id, :body, images: [])
  end

end
