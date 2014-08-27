class ArticleService
  def find(params)
    time = Time.at(params[:id].to_i)
    dir = Pathname.new(Settings[:article][:path]).join(time.year.to_s)
    path = Dir::glob(dir.join("#{params[:id]}_*.md").to_s).first
    if path
      content = File.read(path)
      Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(content).chomp
    else
      fail ResourceNotFound
    end
  end
end
