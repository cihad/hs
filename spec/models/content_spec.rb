require 'rails_helper'

RSpec.describe Content do
  
  it { is_expected.to have_attribute :title }
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to have_attribute :body }
  it { is_expected.to validate_presence_of :body }
  it { is_expected.to have_one :node }

  it "updates node attributes after saved" do
    content = build :content
    content.save
    expect(content.node.title).to eq content.title
  end

  it ".search" do
    content1 = create :content, title: "Example Content", body: "This is a content"
    content2 = create :content, title: "Sample Content", body: "A Beautiful Day!"
    content3 = create :content, title: "Another Thing", body: "Yes it is"

    
    results = described_class.search("example content")

    expect(results).to match_array [content1, content2]
    expect(results).to_not include content3
  end


end