class SessionsController < ApplicationController
  def new
    
  end

  def create
    #render new
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "Come in... we have coffee"
      redirect_to user_path(user)
    else
      flash.now[:danger] = "The fuck are you?"
      render 'new'
    end
    
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "ΟΥΣΤ!!!! ΆΜΠΑΛΕ!!!!"
    redirect_to root_path
  end

end
