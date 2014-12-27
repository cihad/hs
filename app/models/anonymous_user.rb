class AnonymousUser < User

  def first_name
    "Anonymous"
  end

  def last_name
    "User"
  end

  def name
    first_name
  end

  def username
    "anonymous"
  end

  def email
    "anonymous@example.com"
  end

end