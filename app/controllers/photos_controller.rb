class PhotosController < ApplicationController
  before_filter :load_item
  before_filter :initialize_photos_session

  def create
    @photo = create_photo
    if @photo.valid?
      unless @item
        session[:photos_ids] << @photo.id.to_s
      end
      render json: @photo
    else
      notify_airbrake(error_message: @photo.errors)
      render nothing: true, status: :unprocessable_entity
    end
  end

  def destroy
    if @item
      @item.photos.destroy(params[:id])
    else
      if session[:photos_ids].include?(params[:id])
        session[:photos_ids].delete(params[:id])
        Photo.destroy(params[:id])
      end
    end
    head :ok
  end

  private

  def load_item
    @item = Item.where(id: params[:id]).first
  end

  def initialize_photos_session
    unless @item
      session[:photos_ids] ||= []
    end
  end

  def create_photo
    if @item
      Photo.create(file: params[:file], item: @item)
    else
      Photo.create(file: params[:file])
    end
  end
end
