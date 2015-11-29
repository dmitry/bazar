class BaseController < ApplicationController
  before_filter :set_locale

  protected

  def set_locale
    current_locale = params[:locale] || I18n.default_locale

    if params[:from_locale]
      cookies.permanent[:locale] = current_locale
    end

    if controller_name == 'home' && !params[:from_locale]
      selected_locale = get_locale

      if current_locale.to_s != selected_locale.to_s
        redirect_to root_path(locale: selected_locale)
      end
    end

    I18n.locale = current_locale
  end

  def default_url_options(*)
    locale = I18n.locale == I18n.default_locale ? nil : I18n.locale
    {
      locale: locale
    }
  end

  def get_locale
    unless cookies[:locale]
      locale = http_accept_language.compatible_language_from(I18n.available_locales)
      cookies.permanent[:locale] = locale
    end
    cookies[:locale]
  end
end