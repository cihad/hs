require 'rails_helper'

RSpec.describe AnonymousUser, type: :model do

  it { is_expected.to_not be_persisted }
  it { is_expected.to be_anonymous }

  it "doesn't persist" do
    expect { subject.save(false) }.to_not change { User.count }
  end

end