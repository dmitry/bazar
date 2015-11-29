class HomeController < BaseController
  def index
    @items = Item.
      recent.
      includes(:photos, :translations, category: :translations, condition: :translations).
      decorate
  end
end
