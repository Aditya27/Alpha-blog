class ArticlesController < ApplicationController
  
  before_action :set_article, only: [:edit, :update, :show, :destroy]

  def new
  	@article = Article.new
  end

  def edit
  	
  end

  def index
  	@article = Article.all
  end

  def create
  	#render plain: params[:article].inspect
  	@article = Article.new(articles_params)
  	if @article.save
  	  flash[:notice] = "The article was created successfully!"
	  redirect_to article_path(@article)
	else
		render 'new'
	end
  end

  def update
  	if @article.update(articles_params)
  	  flash[:notice] = "The article was updated successfully!"
	  redirect_to article_path(@article)
	else
		render 'edit'
	end
  end

  def show
  end

  def destroy
  	@article.destroy
  	flash[:notice] = "The article was deleted successfully!"
  	redirect_to articles_path
  end

  private

    def set_article
      @article = Article.find(params[:id])
    end

    def articles_params
      params.require(:article).permit(:title,:description)
    end

end