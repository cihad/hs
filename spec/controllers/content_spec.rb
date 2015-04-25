require 'rails_helper'
require 'controllers/concerns/contents'

RSpec.describe ContentsController, type: :controller do
  it_behaves_like "contents" do
    let(:klass) { Content }
    let(:content) { create :content }
  end
end