require 'rails_helper'

feature "User" do

  def login_with email, password = "123456"
    visit "users/login"
    within "form#new_user" do
      fill_in "user_email", with: email
      fill_in "user_password", with: password
      click_on I18n.t('sessions.login')
    end
  end
  
  let!(:user) { create :user, name: "Name", email: "name@example.org" }

  scenario "registration creates a new user" do
    visit "users/register"
    expect {
      fill_in "user_name",        with: "Name"
      fill_in "user_username",    with: "a_nice_username"
      fill_in "user_email",       with: "user@example.org"
      fill_in "user_password",    with: "secretpassword"
      fill_in "user_password_confirmation",with: "secretpassword"
      click_on I18n.t('registrations.register')
    }.to change(User, :count).by(1)
  end

  describe "sessions" do
    scenario "sessions log in the user" do
      login_with "name@example.org"
      expect(page).to have_content "Name"
    end

    scenario "sessions logout the user" do
      login_with "name@example.org"
      click_on I18n.t('sessions.logout')
      expect(page).to_not have_content "Name"
    end
  end

  scenario "edits user information" do
    login_with "name@example.org"
    click_on I18n.t('registrations.edit')
    expect {
      within "form#edit_user" do
        fill_in "user_name", with: "Thename"
        fill_in "user_current_password", with: "123456"
        click_on I18n.t('helpers.submit.update')
      end
      user.reload
    }.to change { user.name }.from("Name").to("Thename")
  end

end