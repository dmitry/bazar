class HomeController < ApplicationController
  def index
    @items = Item.
      recent.
      includes(:photos, :translations, category: :translations, condition: :translations).
      decorate
  end
end
