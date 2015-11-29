class Constants
  LANGUAGES = {
    en: 'English',
    ru: 'Русский',
    es: 'Español'
  }

  def self.languages
    sort_languages(Constants::LANGUAGES)
  end

  def self.sort_languages(hash)
    hash.sort_by do |l, _|
      l == I18n.locale ? 0 : 1
    end
  end
end
