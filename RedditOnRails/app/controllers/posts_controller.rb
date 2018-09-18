class PostsController < ApplicationController
  before_action :require_login
  
  def new 
    @post = Post.new 
    render :new
  end 
  
  def create 
    @post = Post.new(post_params)
    @post.sub_id = params[:sub_id]
    @post.user_id = current_user.id 
    if @post.save 
      redirect_to post_url(@post)
    else 
      flash.now[:errors] = @post.errors.full_messages 
      render :new
    end
  end 
  
  def edit 
    @post = Post.find(params[:id])
    render :edit
  end 
  
  def update 
    @post = Post.find(params[:id])
    sub_id = @post.sub_id
    
    unless @post.author == current_user
      flash[:errors] = ['You are not the author of this post']
      redirect_to post_url(@post)
    end
    
    if @post.update(post_params)
      redirect_to post_url(@post)
    else 
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end 
  
  
  def show 
    @post = Post.find(params[:id])
    render :show
  end
  
  def destroy 
    @post = Post.find(params[:id])
    sub_id = @post.sub_id
    @sub = Sub.find(sub_id)
    @post.destroy
    redirect_to sub_url(@sub)
  end
  
  private 
  
  def post_params
    params.require(:post).permit(:title, :url, :content)
  end
end
