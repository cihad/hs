require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  
  it '#comment_path' do
    comment = create :comment
    allow(controller).to receive(:node_path).and_return("sample_node_path")
    expect(controller.comment_path(comment)).to eq("sample_node_path")
  end

end