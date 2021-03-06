module ApplicationHelper

  def full_title page_title
    page_title.empty? ? t('site.name') : "#{page_title} - #{t('site.name')}".html_safe
  end

  def title title
    provide :title, title
  end

  def page_title title
    render 'page_header', title: title
  end

  def form_row label, &block
    render layout: 'form_row', locals: { label: label }, &block
  end

  def description description
    provide :description, description
  end

  def list_nodes nodes
    render 'nodes/node_list', nodes: nodes
  end

  def content_form_for content, &block
    render layout: 'nodes/form', locals: {content: content}, &block
  end

  def partial name, *others, &block
    render layour: name, locals: others, &block
  end

  def new_node_path type = nil, *args
    type ? send(:"new_#{type.to_s.underscore}_path", *args) : super
  end

  def edit_node_path node, *args
    #binding.pry
      send(:"edit_#{node.content_type.to_s.underscore}_path", node.content, *args)
  end

  # Docs: https://en.gravatar.com/site/implement/images/
  def gravatar_url_for email, size: 120
    hash = Digest::MD5.hexdigest(email)
    default_avatar = Rails.env.production? ? CGI.escape(url_to_image "user.jpg") : "mm"
    "http://www.gravatar.com/avatar/#{hash}?size=#{size}&d=#{default_avatar}"
  end

  def submit_button f: nil, button_text: nil
    render 'submit_button', f: f, button_text: button_text
  end

  # TODO: Test
  def markdown text
    options = [:tables, :hard_wrap, :filter_html, :autolink, :no_intraemphasis, :fenced_code, :gh_blockcode]
    exts = {}
    options.each { |k| exts[k] = true }
    
    Redcarpet::Markdown.new(Redcarpet::Render::HTML, exts).render(text).html_safe
  end

end
