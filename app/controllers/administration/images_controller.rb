module Administration
  class ImagesController < BaseController

    before_filter :image, only: :destroy

    def index
      @images = Image.all
    end

    def destroy
      authorize @image
      @image.destroy
      redirect_to administration_images_path, notice: I18n.t('images.flash.destroyed')
    end

  private

    def image
      @image = Image.find params[:id]
    end

  end
end