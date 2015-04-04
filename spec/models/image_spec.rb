require 'rails_helper'

RSpec.describe Image, :type => :model do

  it { is_expected.to have_attribute :title }
  it { is_expected.to have_attribute :image }
  it { is_expected.to have_many :content_images }
  it { is_expected.to have_many :contents }
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :image }

  it "mount uploader image" do
    expect(described_class.uploaders.keys).to be_include :image
  end

end
