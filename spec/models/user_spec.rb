require 'rails_helper'

RSpec.describe User, :type => :model do

  let(:superadmin)    { create :superadmin }
  let(:admin)         { create :admin }
  let(:authenticated) { create :authenticated }
  let(:anonymous)     { create :anonymous }

  it { is_expected.to have_attribute :name }
  it { is_expected.to have_attribute :username }
  it { is_expected.to validate_presence_of :username }
  it { is_expected.to validate_uniqueness_of :username }
  it { is_expected.to have_attribute :email }
  it { is_expected.to have_attribute :role }
  it { is_expected.to have_many :nodes }
  it { is_expected.to have_many :comments }

  it "username format" do
    expect(subject).to allow_value("example").for(:username)
    expect(subject).to allow_value("Example").for(:username)
    expect(subject).to allow_value("example_user").for(:username)

    # TODO
    # expect(subject).to_not allow_value("_____").for(:username)
    expect(subject).to_not allow_value("türkçeisim").for(:username)
    expect(subject).to_not allow_value("example-user").for(:username)
    expect(subject).to_not allow_value("example.org").for(:username)
  end

  it "#manager?" do
    expect(superadmin).to be_manager
    expect(admin).to be_manager
    expect(authenticated).to_not be_manager
    expect(anonymous).to_not be_manager
  end

  it "#<=>" do
    expect(superadmin <=> admin).to eq(1)
    expect(authenticated <=> admin).to eq(-1)
    expect(authenticated <=> create(:authenticated)).to eq(0)
  end

  it "#is_greater_than?" do
    expect(admin).to be_is_greater_than :anonymous
    expect(authenticated).to_not be_is_greater_than :superadmin
  end

  it '#chef?' do
    expect(superadmin).to be_chef admin
    expect(admin).to be_chef authenticated
    expect(authenticated).to_not be_chef admin
  end

  it '#registered?' do
    expect(admin).to be_registered
    expect(superadmin).to be_registered
    expect(authenticated).to be_registered
    expect(anonymous).to_not be_registered
  end



end
