class ArticleService
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
end
