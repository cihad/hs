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

end
