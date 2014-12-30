module ApplicationHelper

  def full_title page_title
    page_title.empty? ? t('site.name') : "#{page_title} - #{t('site.name')}".html_safe
  end

  def title title
    provide :title, title
  end

  def description description
    provide :description, description
  end

  def list_nodes nodes
    render 'nodes/node_list', nodes: nodes
  end
  def bubble_box &block
    render layout: 'bubble_box', &block
  end

  def box &block
    render layout: 'box', &block
  end

  def gravatar_url_for email, size: 120
    hash = Digest::MD5.hexdigest(email)
    "http://www.gravatar.com/avatar/#{hash}?size=#{size}"
  end

  def submit_button f: nil, button_text: nil
    render 'submit_button', f: f, button_text: button_text
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
