class ArticleService
  def search(params)
    dir = Pathname.new(Settings.article.path)
    Dir::glob(dir.join("*_*.md").to_s).map do |path|
      Article.new(path)
    end
  end

  def find(params)
    dir = Pathname.new(Settings.article.path)
    path = Dir::glob(dir.join("#{params[:id]}_*.md").to_s).first
    if path
      Article.new(path)
    else
      fail ResourceNotFound
    end
  end
end
