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

  validates :name, presence: true

  scope :by_phone_or_email, -> phone, email do
    where(
      arel_table[:phone].eq(phone).or(
        arel_table[:email].eq(email)
      )
    )
  end
end
