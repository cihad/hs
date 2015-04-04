require "rails_helper"

RSpec.describe NodePolicy do
  subject { described_class.new user, node }

  let(:user) { double }
  let(:node) { double }

  it "#new?" do
    allow(subject).to receive(:create?).and_return(perm = double)
    expect(subject.new?).to eq perm
  end

  describe "#update?" do
    it 'permits when current user is node owner' do
      allow(node).to receive(:owner?).with(user).and_return(true)
      expect(subject.update?).to be true
    end

    it 'permits when current user is chef of node author' do
      allow(node).to receive(:author).and_return(double)
      allow(node).to receive(:owner?).with(user).and_return(false)
      allow(user).to receive(:chef?).with(node.author).and_return(true)

      expect(subject.update?).to be true
    end
  end

  it "#edit?" do
    allow(subject).to receive(:update?).and_return(perm = double)
    expect(subject.edit?).to eq perm
  end

  it "#create?" do
    allow(user).to receive(:is_greater_than?).with(:anonymous).and_return(perm = double)
    expect(subject.create?).to eq perm
  end

  describe "#destroy?" do
    it "permits when current user is node owner" do
      allow(node).to receive(:owner?).with(user).and_return(true)
      expect(subject.destroy?).to be true
    end

    it "permits when current user is manager" do
      allow(node).to receive(:owner?).with(user).and_return(false)
      allow(user).to receive(:manager?).and_return(true)
      expect(subject.destroy?).to be true
    end
  end

  describe "#permitted_attributes" do
    it "when current user isn't manager" do
      attrs = %i(title body tag_list)
      allow(user).to receive(:manager?).and_return false
      expect(subject.permitted_attributes).to_not be_include :status
      expect(subject.permitted_attributes).to match attrs
    end

    it "when current user is manager" do
      allow(user).to receive(:manager?).and_return true
      expect(subject.permitted_attributes).to be_include :status
    end
  end




end