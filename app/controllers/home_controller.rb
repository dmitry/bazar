class HomeController < ApplicationController
  def index
    @items = Item.recent.decorate
  end
end
