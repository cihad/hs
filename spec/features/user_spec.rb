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
           name: "Name",
           email: "name@example.org"
  end

  it "registrations creates a new user" do
    visit new_user_registration_path

    expect {
      fill_in "user_name",        with: "Name"
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

      expect(page).to have_content "Name"
    end

    it "sessions logout the user" do
      login_with "name@example.org"

      click_on I18n.t('sessions.logout')
      expect(page).to_not have_content "Name"
    end
  end

  it "edits user information" do
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