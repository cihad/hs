require 'rails_helper'

RSpec.describe 'Comment', type: :feature do
  
  let(:node) { (create :content).node }
  let(:user) { create :authenticated }
  let(:comment) { create :comment, body: "Example Comment !!!", author: user, node: node }

  before do
    login user
  end

  it 'creates' do
    visit node_path node
    fill_in "comment_body", with: "New Comment !!!"
    click_button I18n.t('helpers.submit.create')
    expect(page).to have_content "New Comment !!!"
  end

  it 'edits' do
    comment # initialize
    visit node_path node
    within "#comment_#{comment.id}" do
      click_link I18n.t('common.edit')
    end
    fill_in "comment_body", with: "Example Comment !!!"
    click_button I18n.t('helpers.submit.update')
    expect(page).to have_content "Example Comment !!!"
  end

  it 'deletes' do
    comment # initialize
    visit node_path node
    within "#comment_#{comment.id}" do
      click_link I18n.t('common.delete')
    end
    expect(page).to_not have_content "Example Comment !!!"
  end

end