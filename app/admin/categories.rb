ActiveAdmin.register Category do
  permit_params(
    translations_attributes: [:id, :locale, :name]
  )

  menu priority: 2, parent: 'Additional'
  actions :all, except: [:show]
  config.sort_order = 'created_at_desc'
  form partial: 'form'

  config.clear_sidebar_sections!
end
