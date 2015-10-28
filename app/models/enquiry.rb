class Enquiry < ActiveRecord::Base
  belongs_to :item

  validates :email, email: true, presence: true
end
