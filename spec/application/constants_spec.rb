require 'rails_helper'

RSpec.describe Hs::Application do
  
  specify do
    expect(TEAM).to be
    expect(TEAM).to be_respond_to :email
    expect(TEAM).to be_respond_to :username
    expect(TEAM).to be_respond_to :name
  end

  specify do
    expect(ANONYMOUSUSER.class.to_s).to eq "AnonymousUser"
  end

end