class Node < ActiveRecord::Base

  # Validations
  validates :title, presence: true
  validates :body, presence: true
end
