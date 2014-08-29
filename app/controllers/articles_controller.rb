class ArticlesController < ApplicationController
  def index
    @articles = ArticleService.new.search(params)
  end

  def show
    @article = ArticleService.new.find(params)
  end
end
