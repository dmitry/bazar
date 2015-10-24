module ActiveAdmin::ViewsHelper
  def item_translations_status(item)
    item.all_translations.values.map do |t|
      color = 'green'
      color = 'orange' if t.name.blank?
      color = 'red' if t.description.blank? || t.name.blank?

      if t.locale.to_sym != I18n.default_locale && t.name == item.all_translations[I18n.default_locale].name
        color = ''
      end

      content_tag_string(:span, t.locale, class: "#{color} status_tag")
    end.join('').html_safe
  end
end