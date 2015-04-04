require 'rails_helper'

RSpec.describe ApplicationPolicy do
  subject { described_class.new(user, record) }

  let(:record) { double }
  let(:user) { double }

  it { is_expected.to_not be_index }
  it { is_expected.to_not be_show }
  it { is_expected.to_not be_new }
  it { is_expected.to_not be_create }
  it { is_expected.to_not be_edit }
  it { is_expected.to_not be_update }
  it { is_expected.to_not be_destroy }
end