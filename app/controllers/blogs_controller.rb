class BlogsController < ApplicationController

  def index
    @blogs = Blog.page(params[:page]).reverse_order
    @tag_list=Tag.all
  end

  def show
    @blog = Blog.find(params[:id])
    @blog_comment = BlogComment.new
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

  private

  def blog_params
    params.require(:blog).permit(:image, :title, :place_id, :body)
  end

end
