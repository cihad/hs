class Comment < ActiveRecord::Base

  # Associations
  belongs_to :author, class_name: "User"
  belongs_to :node, touch: true, required: true

  # Validations
  validates :body, :node_id, presence: true
  validate :email_or_author

  def owner? user
    author == user
  end

  def user
    @user ||= author || AnonymousUser.new(email: email)
  end

  def email_or_author
    errors.add(:email_or_author) unless email or author_id
  end

  def authenticate_key
    BCrypt::Engine.hash_secret comment_param, Rails.application.secrets.salt
  end

  def valid_key? key
    authenticate_key.to_s == key.to_s
  end

  private

  def comment_param
    "comment%s%s" % [id, created_at.to_i]
  end
end
