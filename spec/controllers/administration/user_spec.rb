require 'rails_helper'

module Administration
  RSpec.describe UsersController, type: :controller do
    
    let(:user) { create :admin }

    before do
      allow(controller).to receive(:current_user).and_return(user)
    end

    it "#index" do
      allow(User).to receive_message_chain(:all, :order).and_return(users = double)
      get :index
      expect(assigns(:users)).to eq users
    end    

    it '#edit' do
      get :edit, id: user
      expect(assigns(:user)).to eq user
    end

    describe '#update' do
      context "with valid attributes" do
        before do
          patch :update, id: user, user: attributes_for(:user, email: "user@example.org")
        end

        it "changes the user attributes" do
          user.reload
          expect(user.email).to eq "user@example.org"
        end

        it "redirects to administration users path" do
          expect(response).to redirect_to administration_users_path
        end
      end

      context 'with unvalid attributes' do
        before do
          patch :update, id: user, user: attributes_for(:user, email: nil)
        end

        it "doesn't change the user attributes" do
          user.reload
          expect(user.email).to_not be_nil
        end

        it "re-renders edit" do
          expect(response).to render_template :edit
        end
      end
    end
  end
end