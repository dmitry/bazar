class Item < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  belongs_to :condition

  has_many :photos, dependent: :destroy

  has_translations :name, :description
  accepts_nested_attributes_for :translations

  before_validation do
    translations.each do |translation|
      if ItemTranslation::COLUMNS.all? { |attr| translation.send(attr).blank? }
        translation.mark_for_destruction
      end
    end
  end

  validates :price, :category, :condition, presence: true
  validates :price, numericality: {:>= => 0, only_integer: true}


  scope :recent, -> { order('created_at DESC') }

  def general_photo
    photos.first || Photo.new
  end
end
