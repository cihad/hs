require 'rails_helper'

RSpec.describe DashboardPolicy do
  
  subject { described_class.new user, nil }

  let(:user) { double }

  it '#show?' do
    allow(user).to receive(:manager?).and_return(perm = double)
    expect(subject.show?).to eq perm
  end

end