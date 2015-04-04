require "rails_helper"

RSpec.shared_examples "taggable" do

  let(:tag) { create :tag }

  it { is_expected.to have_many :taggings }
  it { is_expected.to have_many :tags }

  it "#tag_list" do
    tag1 = create :tag, name: "one"
    tag2 = create :tag, name: "two"

    subject.tags << tag1 << tag2
    subject.save

    expect(subject.tag_list).to be_include "one, two" 
  end

  it "#tag_list=" do
    expect {
      subject.tag_list = "one, two"
      subject.save
    }.to change { subject.tags.count }.by(2)
  end

  it "#tag_list= finds existing tags" do
    create :tag, name: "one"
    create :tag, name: "two"

    subject.save

    expect {
      subject.tag_list = "one, two"
      subject.save
    }.to_not change { Tag.count }
  end

end