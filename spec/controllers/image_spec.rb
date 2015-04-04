require 'rails_helper'

RSpec.describe ImagesController, type: :controller do
  let(:content) { create :content_with_images }
  let(:image) { content.images.first }
  let(:user) { create :admin }

  before do
    content.node.update author: user
    allow(controller).to receive(:current_user).and_return(content.node.author)
  end

  it '#show' do
    get :show, id: image
    expect(assigns(:image)).to eq image
  end

  it '#edit' do
    get :edit, id: image
    expect(assigns(:image)).to eq image
  end

  describe "#update" do
    context 'with valid attributes' do
      it "changes image attributes" do
        expect {
          patch :update, id: image, image: attributes_for(:image, title: "title !!!!")
          image.reload
        }.to change { image.title }
      end

      it "redirects to image" do
        patch :update, id: image, image: attributes_for(:image, title: "title !!!!")
        expect(response).to redirect_to image_path(image)
      end
    end

    context "with unvalid attributes" do
      it "doesn't change image attributes" do
        expect {
          patch :update, id: image, image: attributes_for(:image, title: nil)
          image.reload
        }.to_not change { image.title }
      end

      it "re-renders template new" do
        patch :update, id: image, image: attributes_for(:image, title: nil)
        expect(response).to render_template :edit  
      end
    end

  end

end