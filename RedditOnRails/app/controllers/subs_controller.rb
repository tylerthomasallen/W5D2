class SubsController < ApplicationController
  
  before_action :require_login
  
  def new
    @sub = Sub.new
    render :new
  end
  
  def create
    @sub = Sub.new(sub_params)
    @sub.user_id = current_user.id
    
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
    
  end
  
  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end
  
  def update
    @sub = Sub.find(params[:id])
    
    unless @sub.moderator == current_user
      flash[:errors] = ['You are not the owner of this sub']
      redirect_to subs_url
    end
    
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end
  
  def destroy
    @sub = Sub.find(params[:id])
    
    unless @sub.moderator == current_user
      flash[:errors] = ['You are not the owner of this sub']
      redirect_to subs_url
    end
    
    @sub.destroy
    redirect_to subs_url
  end
  
  def index
    @subs = Sub.all
    render :index
  end
  
  def show
    @sub = Sub.find(params[:id])
    render :show
  end
  
  private
  
  def sub_params
    params.require(:sub).permit(:title, :description)
  end
  
end
