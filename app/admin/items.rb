ActiveAdmin.register Item do
  permit_params(
    :price,
    :category_id,
    :condition_id,
    translations_attributes: [:id, :locale, :name, :description]
  )

  menu priority: 1
  actions :all, except: [:show]
  config.sort_order = 'created_at_desc'
  form partial: 'form'

  config.clear_sidebar_sections!

  before_create do |r|
    r.user_id = current_user.id

    @photos = photos_from_session
    @photos.each do |photo|
      r.photos << photo
    end
  end

  after_create do
    if resource.persisted?
      reset_photos_session
    end
  end


  index do
    id_column

    column class: 'col-photo' do |p|
      if p.main_photo && p.main_photo.file?
        link_to image_tag(p.main_photo.file.url(:small), size: '64x64'), edit_admin_item_path(p)
      end
    end

    column :translations do |c|
      item_translations_status(c)
    end

    column :price do |c|
      c.price
    end

    column :category do |c|
      c.category.name
    end

    column :condition do |c|
      c.condition.name
    end

    column :user do |c|
      c.user.email
    end

    actions
  end


  collection_action :photos, method: :post do
    photo = Photo.create(file: params[:photo][:file])
    session[:photos] << photo.id
    render text: 'test'
  end


  controller do
    before_filter :initialize_photos_session

    def new
      new! do |format|
        @photos = photos_from_session

        format.html
      end
    end

    def edit
      edit! do |format|
        @photos = resource.photos

        format.html
      end
    end

    def update
      update! do |format|
        @photos = resource.photos

        format.html
      end
    end

    private

    def photos_from_session
      Photo.without_item.where(id: session[:photos])
    end

    def reset_photos_session
      session[:photos] = []
    end

    def initialize_photos_session
      session[:photos] ||= []
    end
  end
end
