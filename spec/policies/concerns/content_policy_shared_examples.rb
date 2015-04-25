require "rails_helper"

RSpec.shared_examples "content_policy" do

  subject { described_class.new current_user, content }

  let(:current_user) { double }
  let(:content) { double }

  it "#new?" do
    allow(subject).to receive(:create?).and_return(perm = double)
    expect(subject.new?).to eq(perm)
  end

  context "#update?" do
    it "if node owner is current user" do
      allow(content).to receive_message_chain(:node, :owner?).with(current_user).and_return(true)
      expect(subject.update?).to be true
    end

    it "if node owner isn't current user and node author's chef is current user" do
      node_author = double
      allow(content).to receive_message_chain(:node, :owner?).with(current_user).and_return(false)
      allow(content).to receive_message_chain(:node, :author).and_return(node_author)
      allow(current_user).to receive(:chef?).with(node_author).and_return(true)
      expect(subject.update?).to be true
    end
  end

  it "#edit?" do
    allow(subject).to receive(:update?).and_return(perm = double)
    expect(subject.edit?).to eq(perm)
  end

  it "#create?" do
    allow(current_user).to receive(:is_greater_than?).with(:anonymous).and_return(perm = double)
    expect(subject.create?).to eq(perm)
  end

  context "#destroy?" do
    it "if current_user is node owner" do
      allow(content).to receive_message_chain(:node, :owner?).with(current_user).and_return(true)
      expect(subject.destroy?).to be true
    end

    it "if current_user isn't node owner and current user is manager" do
      allow(content).to receive_message_chain(:node, :owner?).with(current_user).and_return(false)
      allow(current_user).to receive(:manager?).and_return(perm = double)
      expect(subject.destroy?).to eq perm
    end
  end

end