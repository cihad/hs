class ImagesController < ApplicationController

  before_filter :image, only: [:show, :edit, :update]
  respond_to :json, only: %i(create)

  def show
  end

  def create
    if image = Image.create(image_params)
      render json: { image_path: image.image_url }
    end
  end

  def edit
    authorize @image
  end

  def update
    authorize @image
    if @image.update(image_params)
      redirect_to @image, notice: I18n.t('images.flash.updated')
    else
      render action: :edit
    end
  end

private
  
  def image
    @image = Image.find params[:id]
  end

  def image_params
    params.require(:image).permit(:title, :image)
    # params.require(:picture).permit(:image)
  end

end
