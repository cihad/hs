class ProductJsonToModel
  attr_reader :product

  def initialize params, content
    @product = params[params[:controller].singularize.to_sym]
    @content = content

    @product[:node_attributes] = {} unless @product.has_key? :node_attributes
  end

  def body!
    body_widgets = product.delete("bodyWidgets") || []
    
    product["body_widgets"] = body_widgets

    body = body_widgets.inject("") do |body, widget|
      body << to_view(widget)
      body
    end

    product[:body] = body
  end

  def id!
    product[:node_attributes][:id] = @content.node.id if @content.try(:node)
  end

  def tag_list!
    tag_list = product.delete("tagList") { [] }
    product["node_attributes"]["tag_list"] = tag_list
  end

  def status!
    product["node_attributes"]["status"] = product.delete("status")
  end

  def body_widgets!
    product["body_widgets"] = product["body_widgets"].to_json
  end

  def convert!
    id!
    tag_list!
    body!
    status!
    body_widgets!
  end

  protected

  def to_hs_header widget
    "<%s>%s</%s>" % [widget[:config][:tag], widget[:value], widget[:config][:tag]]
  end

  def to_bootstrap_paragraph widget
    paragraph = ""
    paragraph << "<div class='lead'>" if widget[:config] and widget[:config][:lead]
    paragraph << widget[:value]
    paragraph << "</div>" if widget[:config] and widget[:config][:lead]
    paragraph
  end

  def to_hr widget
    "<hr>"
  end

  def to_bootstrap_image widget
    image_path  = widget[:value][:url]
    caption     = widget[:value][:caption]
    type        = widget[:config][:type]

    str = "<figure>"
    str << "<img src=\"%s\" " % image_path
    str << "class=\"img-%s\" " % type
    str << "title=\"%s\" " % caption unless caption.blank?
    str << "/>"
    str << "<figcaption>%s</figcaption>" % caption unless caption.blank?
    str << "</figure>"
  end

  def to_bootstrap_table widget
    classes = ['table']
    classes << "table-striped" if widget[:config][:striped]
    classes << "table-bordered" if widget[:config][:bordered]
    classes << "table-hover" if widget[:config][:hover]
    classes << "table-condensed" if widget[:config][:condensed]
    classes = classes.join(" ")

    str = "<table class='%s'>" % classes

    widget[:config][:rowCount].times do |row|
      str << "<tr>"
      widget[:config][:columnCount].times do |col|
        str << "<td>"
        str << widget[:value][row][col]
        str << "</td>"
      end
      str << "</tr>"
    end

    str << "</table>"
    str
  end

  def to_bootstrap_grid widget
    str = "<div class=\"row\">"
    widget[:config][:columns].each do |column|
      str << "<div class=\"col-md-%s\">" % column.size
      str << to_view(column)
      str << "</div>"
    end

    str << "</div>"
    str
  end

  private

  def to_view widget
    send :"to_#{widget['machineName'].gsub('/', '_')}", widget
  end
end