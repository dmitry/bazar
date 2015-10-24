class ItemTranslation < ActiveRecord::Base
  COLUMNS = %w(name description).freeze

  belongs_to :property

  validates :name, :description, presence: true
end
