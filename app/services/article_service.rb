class ArticleService
  def find(params)
    time = Time.at(params[:id])
    dir = Pathname.new(Settings[:article][:path]).join(time.year.to_s)
    path = Dir::glob(dir.join("#{params[:id]}_*.md").to_s).first
    if path
      File.read(path).chomp
    else
      fail ResourceNotFound
    end
  end
end
