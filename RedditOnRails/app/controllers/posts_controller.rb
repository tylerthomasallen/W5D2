class PostsController < ApplicationController
  
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
    
    if current_user == @post.user && @post.update(post_params)
      redirect_to post_url(@post)
    else 
      flash.now[:errors] = @post.errors ? @post.errors.full_messages : ['Not your post!!!']
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
