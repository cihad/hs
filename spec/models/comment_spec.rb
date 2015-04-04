require 'rails_helper'

RSpec.describe Comment do
  it { is_expected.to belong_to :author }
  it { is_expected.to belong_to :node }
  it { is_expected.to validate_presence_of :body }

  subject { build :comment }

  it "#owner?" do
    expect(subject.owner?(subject.author)).to be true
    expect(subject.owner?((create :comment).author)).to be false
    expect(subject.owner?(AnonymousUser.new)).to be false
  end
end