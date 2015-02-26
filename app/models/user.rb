class User < ActiveRecord::Base
  has_secure_password
  has_many :campaigns, dependent: :destroy
  has_many :pledges, dependent: :nullify

  geocoded_by :address #for Geocoding
  after_validation :geocode

  validates :email, presence: true, uniqueness: true
#1).  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: [:create, :update] }

#2).  validate :email_format
#  def email_format
#  end 

#3). use shared method in /app/validators/
#  validates :email, email_format: true
  validates :email, email_format: { message: "invalid email_format" }

  # User.api_key assignment for user API
  before_create :generate_api_key

  def full_name
    if (first_name || last_name)
      "#{first_name} #{last_name}"
    else
      email
    end
  end

  private

    def generate_api_key
      begin
        self.api_key = SecureRandom.hex
      end while User.exists?(api_key: api_key)
      #Campaign.exists?(title: "Potato Salad 1.0")
    end
end