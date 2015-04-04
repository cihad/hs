require "rails_helper"

feature "Content" do
  
  let(:user) { create :authenticated }

  scenario "User creates a new content" do
    login user
    click_link I18n.t('common.add')
    click_link I18n.t("content_types.content.name")

    fill_in "content_title", with: "Example Title"
    fill_in "content_body", with: "Example Body"

    click_button I18n.t('helpers.submit.create')

    expect(page).to have_content "Example Title"
    expect(page).to have_content "Example Body"
  end

  scenario "User edits the existing content" do
    content = create :content, author: user
    login user

    visit node_path(content.node)

    within "#node_#{content.node.id}" do
      click_link I18n.t('common.edit')
    end

    fill_in "content_title", with: "CHANGE TITLE!!!"
    click_button I18n.t('helpers.submit.update')
    expect(page).to have_content 'CHANGE TITLE!!!'
  end

end