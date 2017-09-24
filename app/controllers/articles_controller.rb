class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  def index
    @articles = Article.paginate(page: params[:page], per_page: 35)
  end
  
  
  def new
    @article = Article.new
  end
  
  def edit
    @article = Article.find(params[:id])
  end

  def create
  @article = Article.new(article_params)
  @article.user = current_user
    if @article.save
      flash[:success] = "Code successfully saved"
      redirect_to article_path(@article)
    else
      render :new
    end
  end
  def show
    if !logged_in?
      flash[:danger] = "You are not part of the gang... sorry!!!"
      redirect_to root_path
    end
    @article = Article.find(params[:id])
  end
  
  
  
  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:warning] = "Code successfully updated"
      redirect_to article_path(@article)
    else
      render :edit
    end
  end
  
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash[:danger] = "Code destroyed!!!!! BOOM!!!"
    redirect_to articles_path
  end
  
  private
    def set_article
      @article = Article.find(params[:id])
    end
  
    def article_params
      params.require(:article).permit(:title, :description)
    end
  
    def require_same_user
      if current_user != @article.user && !current_user.admin?
        flash[:danger] = "The fuck are you???"
        redirect_to root_path
      end
    end
end