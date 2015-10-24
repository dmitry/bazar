class User < ActiveRecord::Base
  has_many :items, dependent: :destroy

  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise(
    :database_authenticatable,
    :recoverable,
    :rememberable,
    :trackable,
    :validatable
  )
end
