class Product < ActiveRecord::Base
  include Contentable

  # Validations
  validates_presence_of :title, :body

  def to_builder
    {
      title: title,
      tagList: node.tags.map(&:name),
      status: node.status || Node.workflow_spec.states.keys.first,
      bodyWidgets: JSON.parse(body_widgets)
    }.to_json
  end

end