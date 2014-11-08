require 'rails_helper'

RSpec.describe Tag, :type => :model do
  
  subject { build :tag, name: "Tag" }

  it "has a name" do
    subject.name
  end

  it "name is uniq" do
    subject.save
    expect { create :tag, name: "tag" }.to raise_error(ActiveRecord::RecordInvalid)
  end

end
  