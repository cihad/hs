require 'rails_helper'
require 'models/concerns/contentable'

RSpec.describe Content do
    
  it_behaves_like "contentable" do
    let(:content) { build :content }
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