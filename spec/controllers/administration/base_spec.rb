require "rails_helper"

module Administration
  RSpec.describe BaseController, type: :controller do
    describe '#authorize_dasboard' do
      it "when current user is a manager" do
        allow(controller).to receive(:current_user).and_return(create :admin)
        get :index
        expect(response).to be_success
      end

      it "when current user isn't a manager" do
        allow(controller).to receive(:current_user).and_return(create :user)
        get :index
        expect(response).to_not be_success
      end
    end    
  end
end