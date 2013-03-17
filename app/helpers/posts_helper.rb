module PostsHelper
  def markdown(text)
    renderer = Redcarpet::Render::HTML.new({
      :filter_html => true,
      :hard_wrap => true
    })
    markdown = Redcarpet::Markdown.new(renderer, {
      :autolink => true,
      :no_intra_emphasis => true,
      :fenced_code => true,
      :gh_blockcode => true
    })

    markdown.render(text).html_safe
  end
end
