class CategoriesController < ApplicationController
  def new
    @category = Category.all
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "New Category created successfully"
      redirect_to categories_path
    else
      render 'new'  
    end
    
  end
  
  def index
    @categories = Category.paginate(page: params[:page], per_page:5)
  end
  
  def show
    
  end
  
  private
  def category_params
    params.require(:category).permit(:name)
  end
  
end