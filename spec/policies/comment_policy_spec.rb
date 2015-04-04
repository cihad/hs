require 'rails_helper'

RSpec.describe CommentPolicy do
  subject { described_class.new(user, record) }

  let(:user) { double }
  let(:record) { double }

  it "#new?" do
    allow(subject).to receive(:create?).and_return(perm = double)
    expect(subject.new?).to eq perm
  end

  it "#create?" do
    allow(user).to receive(:registered?).and_return(perm = double)
    expect(subject.create?).to eq perm
  end

  describe 'update?' do
    it "permit when current user is comment owner" do
      allow(record).to receive(:owner?).with(user).and_return(true)
      expect(subject.update?).to be true
    end

    it "permit when current user is manager" do
      allow(record).to receive(:owner?).with(user).and_return(false)
      allow(user).to receive(:manager?).and_return(true)
      expect(subject.update?).to be true
    end
  end

  it '#edit?' do
    allow(subject).to receive(:update?).and_return(perm = double)
    expect(subject.edit?).to eq perm
  end

  it "#destroy?" do
    allow(subject).to receive(:update?).and_return(perm = double)
    expect(subject.destroy?).to eq perm
  end

end