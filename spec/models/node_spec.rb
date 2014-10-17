require 'rails_helper'

RSpec.describe Node, type: :model do

  subject { create :node }

  it "has title" do
    expect(subject.title).to be
  end

  it "has tldr" do
    expect(subject.tldr).to be
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
end
