class Item < ActiveRecord::Base
  belongs_to :user, autosave: true
  belongs_to :category
  belongs_to :condition

  has_many :photos, dependent: :destroy
  has_many :enquiries, dependent: :destroy

  has_translations *ItemTranslation::COLUMNS, inverse_of: :item
  accepts_nested_attributes_for :translations

  before_validation do
    translations.each do |translation|
      if translation.empty?
        translation.mark_for_destruction
      end
    end
  end

  before_validation do
    new_master = translations.detect do |translation|
      !translation.marked_for_destruction? && translation.locale == I18n.locale
    end
    if new_master
      new_master.source = :master
    end

    old_master = translations.detect do |translation|
      !translation.marked_for_destruction? && translation.master?
    end
    if old_master
      old_master.source = :manual
    end
  end

  validates :price, :category_id, :condition_id, presence: true
  validates :price, numericality: {:>= => 0, only_integer: true}
  validate do
    master_translation = translations.detect(&:master?)
    if master_translation && master_translation.marked_for_destruction?
      master_translation.errors.add(:name, :blank)
      master_translation.errors.add(:description, :blank)
    end
    # TODO errors.add(:base, 'Must be')
  end


  scope :recent, -> { order('created_at DESC') }

  def main_photo
    photos.first || Photo.new
  end

  # def main_locale
  #   main_locale = I18n.locale
  #   translation = all_translations[main_locale]
  #   if ItemTranslation::COLUMNS.all? { |attr| translation.send(attr).blank? }
  #     main_locale
  #   else
  #     translation = all_translations[main_locale]
  #   end
  # end
end
