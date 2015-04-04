require "rails_helper"

RSpec.describe TagsController, type: :controller do
  
  let(:tag) { create :tag }

  it "#show" do
    get :show, id: tag
    expect(assigns(:tag)).to eq tag
  end

end