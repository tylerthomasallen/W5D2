class SessionsController < ApplicationController
  
  def new
    @user = User.new
    render :new
  end
  
  def create
    # debugger
    username = params[:user][:username]
    password = params[:user][:password]
    @user = User.find_by_credentials(username, password)
    if @user 
      login(@user)
      redirect_to links_url
    else
      @user = User.new
      flash.now[:errors] = 'Invalid Login Credentials'
      render :new 
    end
  end
  
  def destroy
    logout
  end
  
end
