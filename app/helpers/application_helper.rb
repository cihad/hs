module ApplicationHelper

  def is_active_page_current?
    current_page?({
      controller: controller_name,
      action:     action_name
    })
  end

  def markdown text
    options = [:tables, :hard_wrap, :filter_html, :autolink, :no_intraemphasis, :fenced_code, :gh_blockcode]
    exts = {}
    options.each { |k| exts[k] = true }
    
    Redcarpet::Markdown.new(Redcarpet::Render::HTML, exts).render(text).html_safe    
  end

end
