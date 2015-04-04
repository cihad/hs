require 'rails_helper'

RSpec.describe NewIdeasHelper, type: :helper do
  it "#idea_body" do
    allow(helper).to receive(:render).with(any_args()).and_return(rendered_html = double)
    expect(helper.idea_body { "sample" }).to eq rendered_html
  end

  it "#idea_comment" do
    allow(helper).to receive(:render).with(any_args()).and_return(rendered_html = double)
    expect(helper.idea_comment { "sample" }).to eq rendered_html
  end

  it '#random_avatar_image' do
    expect(helper.random_avatar_image).to match /amazonaws.com/
  end
end