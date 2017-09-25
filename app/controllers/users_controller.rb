class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to WIKID!!!! #{@user.username}"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end
  
  def edit
  
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = "Good Job #{@user.username}!!! now wipe that crap of the monitor!!!"
      redirect_to articles_path
    else
      render 'edit'
    end
    
  end  
  
  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 10)
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:danger] = "Μόλις έσβησες τα πάντα από τον #{@user.username}... δεν υπήρξε ΠΟΤΕ!!!"
    redirect_to users_path
  end
  
  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
  def set_user
    @user = User.find(params[:id])
  end
  def require_same_user
    if !logged_in? && (current_user != @user || !current_user.admin?)
      flash[:danger] = "You are not... You!!! Play with yourself only unless... you are a MASTA!!!"
      redirect_to root_path
    end
  end
  def require_admin
    if logged_in? and !current_user.admin?
      flash[:danger] = "You are not a MASTA!!!!"
      redirect_to root_path
    end
  end
end