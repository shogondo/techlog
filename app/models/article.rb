class Article
  attr_accessor :path, :title, :content, :created_at

  def title
    if @title.blank? && content.present?
      content.each_line do |line|
        if line =~ /^#+ (.+)$/
          @title = $1
          break
        end
      end
    end
    @title
  end

  def html
    if @html.blank? && content.present?
      renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
      @html = renderer.render(content).chomp
    end
    @html
  end
end
