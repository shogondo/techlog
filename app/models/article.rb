class Article
  def initialize(path)
    fail ArgumentError unless File.exist?(path)
    @path = path
  end

  def content
    @content = File.read(@path) if @content.blank?
    @content
  end

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

  def created_at
    if @created_at.blank?
      if Pathname.new(@path).basename.to_s =~ /^(\d+)_.+\.md$/
        @created_at = Time.zone.at($1.to_i)
      end
    end
    @created_at
  end
end
