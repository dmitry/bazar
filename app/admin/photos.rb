ActiveAdmin.register Photo do
  belongs_to :item

  permit_params :file

  controller do
    def create
      create! do |format|
        format.js { render nothing: true }
      end
    end

    def destroy
      destroy! do |format|
        format.js { render nothing: true }
      end
    end
  end
end
