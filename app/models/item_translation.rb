class ItemTranslation < ActiveRecord::Base
  COLUMNS = %w(name description).freeze

  belongs_to :item

  as_enum :source, [:master, :manual, :bing]

  validates :name, :description, presence: true

  before_validation do
    if !source || (persisted? && machine? && changed?)
      self.source = :manual
    end
  end

  def empty?
    COLUMNS.all? { |attr| send(attr).blank? }
  end

  def human?
    master? || manual?
  end

  def machine?
    !human?
  end
end
