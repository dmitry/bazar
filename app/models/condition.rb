class Condition < ActiveRecord::Base
  has_translations :name
  accepts_nested_attributes_for :translations

  has_many :items, dependent: :restrict_with_exception
end
