require 'rails_helper'
require 'models/concerns/contentable'

RSpec.describe Content do
  

  it_behaves_like "contentable" do
    let(:content) { build :product }
  end

end