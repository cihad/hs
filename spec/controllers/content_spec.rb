require 'rails_helper'

def content_attributes attrs = {}
  hash = { node_attributes: attributes_for(:node) }.merge(attrs)
  attributes_for(:content, hash)
end

RSpec.describe ContentsController, type: :controller do
  let(:current_user) { create :user }
  let(:content) { create :content }

  before do
    allow(controller).to receive(:current_user).and_return(current_user)
  end
  
  describe "#new" do
    it "assigns content as @content" do
      get :new

      expect(assigns(:node)).to be_a_new(Node)
      expect(assigns(:content)).to be_a_new(Content)
    end
  end

  describe '#create' do
    describe "with valid attributes" do
      it "saves the new content in the database" do
        expect {
          post :create, content: content_attributes
        }.to change(Content, :count).by(1)
      end

      it "redirects to nodes#show" do
        post :create, content: content_attributes
        expect(response).to redirect_to node_path(assigns[:content].node)
      end
    end

    describe 'with invalid attributes' do
      it 'does not save the new content in the database' do
        expect {
          post :create, content: content_attributes(title: nil)
        }.to_not change(Content, :count)
      end

      it 're-renders the :new template' do
        post :create, content: content_attributes(title: nil)
        expect(response).to render_template :new
      end
    end
  end

  describe '#edit' do
    before do
      content.node.update author: current_user
    end

    it 'assigns the requested content as @content' do
      get :edit, id: content
      expect(assigns(:content)).to eq(content)
    end

    it 'changes node status from awaiting_review to being_reviewed' do
      expect {
        get :edit, id: content
        content.node.reload
      }.to \
        change { content.node.status }.
        from("awaiting_review").
        to("being_reviewed")
    end
  end

  describe '#update' do
    before do
      content.node.update author: current_user
    end

    context 'with valid attributes' do
      it 'located the requested @content' do
        patch :update, id: content, content: content_attributes
        expect(assigns(:content)).to eq(content)
      end

      it "changes @content's attributes" do
        expect {
          patch :update, id: content, content: content_attributes(title: "TITLE !!!!")        
          content.reload
        }.to change { content.title }
      end

      it 'redirects to node' do
        patch :update, id: content, content: content_attributes
        expect(response).to redirect_to(node_path(assigns(:content).node))
      end
    end

    context 'with invalid attributes' do
      it "does not change the content's attributes" do
        patch :update, id: content, content: content_attributes(title: nil)
        content.reload
        expect(content.title).to_not be_nil
      end

      it 're-renders the edit template' do
        patch :update, id: content, content: content_attributes(title: nil)
        expect(response).to render_template :edit
      end
    end
  end

end