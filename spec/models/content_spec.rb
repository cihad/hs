require 'rails_helper'

RSpec.describe Content do
  
  it { is_expected.to have_attribute :title }
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to have_attribute :body }
  it { is_expected.to validate_presence_of :body }
  it { is_expected.to have_one :node }

  it "#searchable_text_for_title" do
    content = Content.new title: "Example Title"
    expect(content.searchable_text_for_title).to eq "Example Title"
  end

  it "#searchable_text_for_body" do
    content = Content.new body: "Example Body"
    expect(content.searchable_text_for_body).to eq "Example Body"
  end

  it "updates node attributes after saved" do
    content = build :content
    content.save
    expect(content.node.title).to eq content.title
    expect(content.node.body).to eq content.body
  end

end