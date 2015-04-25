require 'rails_helper'
require 'controllers/concerns/contents'

RSpec.describe ProductsController, type: :controller do
  it_behaves_like "contents" do
    let(:klass) { Product }
    let(:content) { create :product }
  end
end