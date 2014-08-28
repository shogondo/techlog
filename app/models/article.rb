class Article
  attr_accessor :path, :title, :content, :created_at

  def html
    if @html.blank? && content.present?
      renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
      @html = renderer.render(content).chomp
    end
    @html
  end
end
