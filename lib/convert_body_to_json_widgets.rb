class ConvertBodyToJsonWidgets

  attr_reader :body, :widgets

  def initialize body
    @body = body
    @widgets = []
  end

  def convert!
    @doc = Nokogiri::HTML(body) do |config|
      config.noblanks
    end

    @doc.xpath("//body/*").each do |element|
      widgets << send(:"to_#{element.name}", element)
    end

    widgets
  end

  def to_p element
    {
      name: "Paragraph",
      machineName: "bootstrap/paragraph",
      version: 1,
      value: element.to_html
    }
  end
  alias_method :to_ol, :to_p
  alias_method :to_ul, :to_p

  def to_header element
    {
      name: "Header",
      machineName: "hs/header",
      version: 1,
      value: element.inner_html,
      config: {
        tag: element.name
      }
    }
  end
  alias_method :to_h1, :to_header
  alias_method :to_h2, :to_header
  alias_method :to_h3, :to_header
  alias_method :to_h4, :to_header
  alias_method :to_h5, :to_header
  alias_method :to_h6, :to_header

  def to_table element
    value = []

    value << element.xpath("//th").inject([]) do |arr, th|
      arr << th.inner_html
      arr
    end

    element.xpath("//tbody/tr").each do |tr|
      value << tr.xpath("td").inject([]) do |arr, td|
        arr << td.inner_html
      end
    end

    rowCount = element.xpath("//tr").size
    columnCount = element.xpath("//th").size

    {
      name: "Table",
      machineName: "bootstrap/table",
      version: 1,
      value: value,
      config: {
        rowCount: rowCount,
        columnCount: columnCount,
        bordered: true,
        condensed: true
      }
    }
  end

end