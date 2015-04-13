require 'rails_helper'

RSpec.describe "time zone" do
  specify do
    expect(Time.zone.name).to eq "Istanbul"
  end
end