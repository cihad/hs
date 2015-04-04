require 'rails_helper'
require 'models/concerns/taggable'


RSpec.describe Node do

  subject { build :node }

  it { is_expected.to belong_to :content }
  it { is_expected.to belong_to :author }
  it { is_expected.to have_many :comments }
  it { is_expected.to have_attribute :title }
  it { is_expected.to have_attribute :body }

  it "#published" do
    published_node        = create :node, status: "published"
    awaiting_review_node  = create :node, status: "awaiting_review"
    expect(described_class.published).to be_include published_node
    expect(described_class.published).to_not be_include awaiting_review_node
  end

  it_behaves_like "taggable"

  describe "Status" do
    before do
      subject.save
    end

    it "is awaiting review" do
      expect(subject).to be_awaiting_review
    end

    it "is being reviewed after review" do
      subject.review!
      expect(subject).to be_being_reviewed
    end

    it "is published after accept" do
      subject.review!
      subject.accept!
      expect(subject).to be_published
    end

    it "is trashed after reject" do
      subject.review!
      subject.reject!
      expect(subject).to be_trashed
    end

    it "is trashed before accept after reject" do
      subject.review!
      subject.accept!
      subject.reject!
      expect(subject).to be_trashed
    end

    it "is published before reject after accept" do
      subject.review!
      subject.reject!
      subject.accept!
      expect(subject).to be_published
    end
  end
end
