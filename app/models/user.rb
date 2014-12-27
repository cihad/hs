class User < ActiveRecord::Base

  include Comparable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Validations
  validates :username, :first_name, :last_name, presence: true
  validates :username,  uniqueness: { case_sensitive: false },
                        format: { with: /\A[a-zA-Z0-9_]+\Z/ },
                        length: { in: 4..20 }

  before_create :downcase_username

  # Associations
  has_many :nodes, dependent: :nullify
  has_many :comments, dependent: :nullify

  # default role is authenticated
  enum role: [:anonymous, :authenticated, :admin, :superadmin]

  def name
    "#{first_name} #{last_name}"
  end

  def manager?
    admin? or superadmin?
  end

  def <=> other_user
    self.class.roles[role] <=> self.class.roles[other_user.role]
  end

  def chef? other_user
    self > other_user
  end

  def registered?
    !anonymous?
  end

private
  
  def downcase_username
    self.username = username.downcase
  end

end
