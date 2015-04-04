require 'rails_helper'

module Administration
  RSpec.describe ImagesController, type: :controller do
    let(:image) { create :image }

    before do
      allow(controller).to receive(:current_user).and_return(create :admin)
    end
    
    it "#index" do
      allow(Image).to receive(:all).and_return(images = double)
      get :index
      expect(assigns(:images)).to eq images
    end


    describe '#destroy' do
      it "deletes the image" do
        delete :destroy, id: image
        expect { image.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it 'redirects to administation images path' do
        delete :destroy, id: image
        expect(response).to redirect_to administration_images_path
      end
      
    end

  end
end