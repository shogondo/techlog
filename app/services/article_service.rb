class ArticleService
  def search(params)
    dir = Pathname.new(Settings.article.path)
    Dir::glob(dir.join("*_*.md").to_s).map do |path|
      create_article(path)
    end
  end

  def find(params)
    dir = Pathname.new(Settings.article.path)
    path = Dir::glob(dir.join("#{params[:id]}_*.md").to_s).first
    if path
      content = File.read(path)
      Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(content).chomp
    else
      fail ResourceNotFound
    end
  end

  private

  def create_article(path)
    renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML)

    article = Article.new
    article.content = File.read(path)
    article.content = renderer.render(article.content).chomp

    article.content.each_line do |line|
      if line =~ /^#+ (.+)$/
        article.title = $1
        break
      end
    end

    path.match /(\d+)_.*\.md/
    article.created_at = Time.at($1.to_i)

    return article
  end
end
