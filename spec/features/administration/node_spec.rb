require 'rails_helper'

RSpec.describe "Node Administration" do

  let!(:node) { create :node, title: "Example Title" }

  it "node is seems on the node administration page" do
    visit administration_nodes_path
    expect(page).to have_content "Example Title"
  end

  it "changes the node status and redirects to node edit page" do
    visit administration_nodes_path
    expect {
      within "#node_#{node.id}" do
        click_on I18n.t('nodes.events.review')
      end
      node.reload
    }.to change { node.current_state }
    expect(current_path).to eq(edit_node_path(node))
  end

  it "Node filter form filters nodes by their status" do
    node = create :node, title: "Another Title"
    node.review!

    visit administration_nodes_path

    select I18n.t('nodes.status.being_reviewed'), from: :node_filter_status
    click_on I18n.t('helpers.submit.node_filter.submit')

    expect(page).to_not have_content("Example Title")
    expect(page).to have_content("Another Title")
  end

end