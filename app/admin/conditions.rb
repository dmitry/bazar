ActiveAdmin.register Condition do
  permit_params(
    translations_attributes: [:id, :locale, :name]
  )

  menu priority: 2, parent: 'Additional'
  actions :all, except: [:show]
  config.sort_order = 'created_at_desc'
  form partial: 'form'

  config.clear_sidebar_sections!


  index do
    I18n.available_locales.each do |locale|
      column "Name #{locale.to_s.upcase}" do |c|
        c.all_translations[locale].name
      end
    end

    actions
  end

end
