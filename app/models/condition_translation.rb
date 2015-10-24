class ConditionTranslation < ActiveRecord::Base
  belongs_to :condition

  validates :name, presence: true
end
