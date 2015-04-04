require 'rails_helper'

RSpec.describe Tag, :type => :model do
  
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to have_many :taggings }
  it { is_expected.to have_many :nodes }
  it { is_expected.to have_many :images }

end
  