class PostController < ApplicationController
  def create
    @post = Post.new(post_params)
    @post.user_id=current_user.id
    # 受け取った値を,で区切って配列にする
    tag_list=params[:post][:name].split(',')
    if @post.save
      @post.save_tag(tag_list)
      redirect_to posts_path(@post),notice:'投稿完了しました:)'
    else
      render:new
    end
  end
  
  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    old_tags.each do |old|
      self.tags.delete　Tag.find_by(name: old)
    end

    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(name: new)
      self.tags << new_post_tag
   end
  end

  def index
    @posts = Post.page(params[:page]).per(10)
    @tag_list=Tag.all
  end

  def show
    @post = Post.find(params[:id])
    @post_comment=PostComment.new
    @post_tags = @post.tags
  end
  
  def edit
    @post = Post.find(params[:id])
    # pluckはmapと同じ意味です！！
    @tag_list=@post.tags.pluck(:name).join(',')
  end


  def update
    @post = Post.find(params[:id])
    tag_list=params[:post][:name].split(',')
    if @post.update(post_params)
       @post.save_tag(tag_list)
       redirect_to post_path(@post.id),notice:'投稿完了しました:)'
    else
      render:edit
    end
  end
  
  
  
end