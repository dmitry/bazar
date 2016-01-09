class ItemsController < BaseController
  def new
    @item = Items::CreateInteraction.new(
      item: Item.new,
      photos_ids: session[:photos_ids]
    )
  end

  def create
    @item = Items::CreateInteraction.run(
      item_params.merge(
        item: Item.new,
        photos_ids: session[:photos_ids]
      )
    )
    if @item.valid?
      redirect_to item_path(@item.item)
    else
      render 'new'
    end
  end

  def show
    @item = Item.find(params[:id]).decorate
    @enquiry = @item.enquiries.build
  end

  def index
    redirect_to new_item_path
  end

  private

  def item_params
    params[:item]
  end
end
