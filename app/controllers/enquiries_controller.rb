class EnquiriesController < BaseController
  before_filter :load_item

  def create
    @enquiry = @item.enquiries.create(enquiry_params)
  end

  private

  def load_item
    @item = Item.find(params[:item_id])
  end

  def enquiry_params
    params.require(:enquiry).permit(:name, :email, :phone, :message)
  end
end
