module PostsHelper
  class CommentMarkdown < Redcarpet::Render::HTML
    def header(title, level)
      case level
      when 1
        "##{title}"
      else
        "<strong>#{title}</strong>"
      end
    end
  end

  def markdown(text)
    markdown = Redcarpet::Markdown.new(CommentMarkdown, {
      :autolink => true,
      :no_intra_emphasis => true,
      :no_styles => true,
      :fenced_code => true,
      :gh_blockcode => true,
      :filter_html => true,
      :hard_wrap => true
    })

    markdown.render(text).html_safe
  end
end
