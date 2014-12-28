require 'rails_helper'

RSpec.describe Node, type: :model do

  subject { build :node }

  it "has title" do
    expect(subject.title).to be
  end

  it "has body" do
    expect(subject.body).to be
  end

  it do
    expect(subject).to validate_presence_of :title
  end

  it do
    expect(subject).to validate_presence_of :body
  end

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
