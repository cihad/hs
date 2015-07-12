class Content < ActiveRecord::Base

  include Contentable
  include Imageable

  # Full text search
  include PgSearch
  multisearchable against: %i(title body)
  pg_search_scope :search, against: { title: 'A', body: 'B' },
                  :using => {
                    :tsearch => {:any_word => true}
                  }

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
