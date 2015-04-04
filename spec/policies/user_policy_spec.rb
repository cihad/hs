require "rails_helper"

RSpec.describe UserPolicy do
  subject { described_class.new current_user, user  }

  let(:user) { double }
  let(:current_user) { double }

  it "#edit?" do
    allow(subject).to receive(:update?).and_return(perm = double)
  end

  describe "#update?" do
    it "when current_user is user" do
      allow(user).to receive(:==).with(current_user).and_return true
      expect(subject.update?).to be true
    end

    it "when current user isn't user and is superadmin" do
      allow(user).to receive(:==).with(current_user).and_return false
      allow(current_user).to receive(:superadmin?).and_return true
      expect(subject.update?).to be true
      
      allow(current_user).to receive(:superadmin?).and_return false
      expect(subject.update?).to be false
    end
  end
end