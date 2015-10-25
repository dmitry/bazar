class ItemsController < ApplicationController
  def show
    @item = Item.find(params[:id]).decorate
  end
end
