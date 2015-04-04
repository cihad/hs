class AnonymousUser < User
  def name
    "Anonymous"
  end

  def username
    "anonymous"
  end

  def email
    "anonymous@example.com"
  end

  def role
    "anonymous"
  end

  def anonymous?
    true
  end

  defined_enums["role"].keys.delete_if { |role| role == "anonymous" }.each do |role|
    define_method :"#{role}?" do
      false
    end
  end

  def persisted?
    false
  end

  def save *args
    false
  end

end