class Product < ActiveRecord::Base
  include Contentable

  # Validations
  validates_presence_of :title, :body

end