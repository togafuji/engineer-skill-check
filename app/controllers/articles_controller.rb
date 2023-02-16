class ArticlesController < ApplicationController
  def index
    @articles = Article.active.order("#{sort_column} #{sort_direction}")
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
    @article.employee = current_user
  end

  def create
    @article = Article.new(article_params)
    @article.employee = current_user
      if @article.save
        redirect_to article_path(@article), notice: "「#{@article.title}」の記事を登録しました。"
      else
        render :new
      end
  end

  def edit
    @article = Article.find(params[:id])
    @article.employee = current_user
  end

  def update
    @article = Article.find(params[:id])
    @article.employee = current_user
    if @article.update(article_params)
      redirect_to articles_path, notice: "「#{@article.title}」の記事を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    article = Article.find(params[:id])
    article.destroy
    redirect_to articles_path, notice:"「#{article.title}」の記事を削除しました。"
  end

  private

  def article_params
    params.require(:article).permit(:employee_id, :title, :content, :author)
  end

  def sort_column
    params[:sort] ? params[:sort] : 'created_at'
  end

  def sort_direction
    params[:direction] ? params[:direction] : 'asc'
  end

end
