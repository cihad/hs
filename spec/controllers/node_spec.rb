require "rails_helper"

RSpec.describe NodesController, type: :controller do

  let(:content1) { create :content }
  let(:node1) { content1.node }
  let(:content2) { create :content }
  let(:node2) { content2.node }

  before do
    node1.update created_at: 1.hour.ago, status: "published"
    node2.update created_at: 2.hour.ago, status: "published"
  end

  describe '#index' do
    it "assigns nodes as @nodes" do
      get :index
      expect(assigns(:nodes)).to match_array([node1, node2])
    end
  end

  describe '#new' do
    it 'success' do
      get :new
      expect(response).to be_success
    end
  end

  describe '#show' do
    let(:node) { double(to_param: 2, id: 2).as_null_object }

    before do
      allow(Node).to receive_message_chain(:includes, :find).with("2").and_return(node)
      get :show, id: node.to_param
    end

    it 'responds succesfully with an HTTP 200 status code' do
      expect(response).to have_http_status(200)
    end

    it 'loads node into @node' do
      expect(assigns(:node)).to eq(node)
    end
  end

  describe '#destroy' do
    context "with authorized user" do
      before do
        allow(controller).to receive(:authorize)
      end

      it "decreases node count" do
        expect {
          delete :destroy, id: node1
        }.to change { Node.count }.by(-1)
      end

      it "redirects to root path" do
        delete :destroy, id: node1
        expect(response).to redirect_to root_path
      end
      
    end

    context 'with unauthorized user' do
      it "doesn't change nodes count" do
        a_user = create :user
        allow(controller).to receive(:current_user).and_return(a_user)
        expect {
          delete :destroy, id: node1
        }.to_not change { Node.count }
      end
    end
  end
end