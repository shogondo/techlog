class ArticlesController < ApplicationController
  def show
    @content = ArticleService.new.find(params)
  end
end
