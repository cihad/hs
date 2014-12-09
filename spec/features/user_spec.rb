require 'rails_helper'

RSpec.describe "User", type: :feature do

  def login_with email, password = "123456"
    visit new_user_session_path
    within "form#new_user" do
      fill_in "user_email", with: email
      fill_in "user_password", with: password
      click_on I18n.t('sessions.login')
    end
  end
  
  let!(:user) do
    create :user,
           first_name: "Firstname",
           last_name: "Lastname",
           email: "name@example.org"
  end

  it "registrations creates a new user" do
    visit new_user_registration_path

    expect {
      fill_in "user_first_name",  with: "Firstname"
      fill_in "user_last_name",   with: "Lastname"
      fill_in "user_username",    with: "firstlast"
      fill_in "user_email",       with: "firstlast@example.org"
      fill_in "user_password",    with: "secretpassword"
      fill_in "user_password_confirmation",with: "secretpassword"
      click_on I18n.t('registrations.register')
    }.to change(User, :count).by(1)
  end


  describe "sessions" do

    it "sessions log in the user" do
      login_with "name@example.org"

      expect(page).to have_content "Firstname Lastname"
    end

    it "sessions logout the user" do
      login_with "name@example.org"

      click_on I18n.t('sessions.logout')
      expect(page).to_not have_content "Firstname Lastname"
    end
  end

  it "edits user information" do
    login_with "name@example.org"
    click_on I18n.t('registrations.edit')

    expect {
      within "form#edit_user" do
        fill_in "user_first_name", with: "Thename"
        fill_in "user_current_password", with: "123456"
        click_on I18n.t('helpers.submit.update')
      end
      user.reload
    }.to change { user.first_name }.from("Firstname").to("Thename")
  end

end