require 'rails_helper'

RSpec.describe ContentImage, :type => :model do

  it { is_expected.to belong_to :content }
  it { is_expected.to belong_to :image }
  it { is_expected.to accept_nested_attributes_for :image }
end
