require 'rails_helper'

RSpec.describe ImagePolicy do
  
  subject { described_class.new user, nil }

  let(:user) { double }

  it '#edit?' do
    allow(subject).to receive(:update?).and_return(perm = double)
    expect(subject.edit?).to eq perm
  end

  it '#update?' do
    allow(user).to receive(:manager?).and_return(perm = double)
    expect(subject.update?).to eq perm
  end

  it "#destroy?" do
    allow(user).to receive(:manager?).and_return(perm = double)
    expect(subject.destroy?).to eq perm
  end

end