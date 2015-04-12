require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:node) { create :node }
  let(:user) { create :user }
  let(:comment) { create :comment, node: node, author: user }

  before do
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe "#create" do
    context "with valid attributes" do
      it "increases comment count" do
        expect {
          post :create, node_id: node.id, comment: attributes_for(:comment)
        }.to change{ node.comments.count }.by(1)
      end

      it "redirects to node path with success message" do
        post :create, node_id: node.id, comment: attributes_for(:comment)
        expect(response).to redirect_to(node_path(assigns(:comment).node))
      end      
    end

    context "with unvalid attributes" do
      it "doesn't change comment count" do
        expect {
          post :create, node_id: node.id, comment: attributes_for(:comment, body: nil)
        }.to_not change { node.comments.count }
      end

      it "re-renders comment form on node show page" do
        post :create, node_id: node.id, comment: attributes_for(:comment, body: nil)
        expect(response).to render_template "nodes/show"
      end
    end
  end

  describe "#edit" do
    before do
      get :edit, node_id: node.id, id: comment
    end

    it "responds succesfully" do
      expect(response).to be_success
    end

    it 'page layout' do
      expect(response).to render_template layout: "page"
    end
  end

  describe "#update" do
    context "with valid attributes" do
      it "redirects to comment" do
        patch :update, node_id: node.id, id: comment, comment: attributes_for(:comment)

        expect(response).to redirect_to controller.comment_path(comment)
      end

    end

    context 'with unvalid attributes' do
      it "re-renders edit comment form" do
        patch :update, node_id: node.id, id: comment, comment: attributes_for(:comment, body: nil)

        expect(response).to render_template :edit
      end

      it "doesn't change comment attributes" do
        patch :update, node_id: node.id, id: comment, comment: attributes_for(:comment, body: nil)
        comment.reload
        expect(comment.body).to_not be_nil
      end
    end
  end

  describe "#destroy" do
    it "deletes" do
      delete :destroy, node_id: node.id, id: comment
      expect { node.comments.find(comment.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "redirects to node path" do
      delete :destroy, node_id: node.id, id: comment
      expect(response).to redirect_to node_path node
    end
  end
end