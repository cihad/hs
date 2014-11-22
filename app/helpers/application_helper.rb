module ApplicationHelper

  def full_title page_title
    page_title.empty? ? t('site_name') : "#{page_title} - #{t('site_name')}"
  end

  def title title
    provide :title, title
  end

  def bubble_box &block
    render layout: 'bubble_box', &block
  end

  def box &block
    render layout: 'box', &block
  end

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
