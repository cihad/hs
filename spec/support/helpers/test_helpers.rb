module TestHelpers
  def t(*args)
    I18n.t(*args)
  end

  def images_dir
    "#{Rails.root}/spec/support/images"
  end

  def login user = create(:authenticated)
    visit "users/login"
    within "form#new_user" do
      fill_in "user_email", with: user.email
      fill_in "user_password", with: user.password
      click_on I18n.t('sessions.login')
    end
  end
  
end