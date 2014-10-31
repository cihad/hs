module TestHelpers
  def t(*args)
    I18n.t(*args)
  end

  def images_dir
    "#{Rails.root}/spec/support/images"
  end
  
end