require 'rails_helper'

RSpec.describe "Node Administration" do

  let!(:node) { (create :content, title: "Example Title").node }
  let(:admin) { create :admin }

  before do
    login admin
  end

  it "node is seems on the node administration page" do
    visit administration_nodes_path
    expect(page).to have_content "Example Title"
  end

  it "Node filter form filters nodes by their status" do
    another_node = (create :content, title: "Another Title").node
    another_node.update status: "being_reviewed"
    node.update status: "published"

    visit administration_nodes_path

    select I18n.t('nodes.status.being_reviewed'), from: :node_filter_status
    click_on I18n.t('helpers.submit.node_filter.submit')

    expect(page).to_not have_content("Example Title")
    expect(page).to have_content("Another Title")
  end

end