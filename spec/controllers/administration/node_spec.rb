require "rails_helper"

module Administration
  RSpec.describe NodesController, type: :controller do
    
    let(:node) { (create :content).node }

    before do
      node.update status: "published"
      allow(controller).to receive(:current_user).and_return(create :admin)
    end

    it '#index' do
      get :index, node_filter: { status: "published" }
      expect(assigns(:nodes)).to match_array [node]
    end

    describe '#destroy' do
      it "deletes the node" do
        delete :destroy, id: node
        expect { node.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it 'redirects to Administration nodes path' do
        delete :destroy, id: node
        expect(response).to redirect_to(administration_nodes_path)
      end
    end

  end
end