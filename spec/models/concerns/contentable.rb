require "rails_helper"

RSpec.shared_examples "contentable" do

  let(:class_name) { described_class.to_s.underscore.to_sym }


  it { is_expected.to have_one :node }
  it { is_expected.to accept_nested_attributes_for :node }
  it { is_expected.to have_many :content_images }
  it { is_expected.to have_many :images }
  it { is_expected.to accept_nested_attributes_for :content_images }

  it { is_expected.to have_attribute :title }
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to have_attribute :body }
  it { is_expected.to validate_presence_of :body }

  it "updates node attributes after saved" do
    content.save
    expect(content.node.title).to eq content.title
  end

  it ".search" do
    content1 = create class_name, title: "Example Content", body: "This is a content"
    content2 = create class_name, title: "Sample Content", body: "A Beautiful Day!"
    content3 = create class_name, title: "Another Thing", body: "Yes it is"

    
    results = described_class.search("example content")

    expect(results).to match_array [content1, content2]
    expect(results).to_not include content3
  end



end