class ItemsController < ApplicationController
  def show
    @item = Item.find(params[:id]).decorate
    @enquiry = @item.enquiries.build
  end
end
