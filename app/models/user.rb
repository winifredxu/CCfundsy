class User < ActiveRecord::Base
  has_secure_password
  has_many :campaigns

  validates :email, presence: true, uniqueness: true
#1).  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: [:create, :update] }

#2).  validate :email_format
#  def email_format
#  end 

#3). use shared method in /app/validators/
#  validates :email, email_format: true
  validates :email, email_format: { message: "invalid email_format" }

  def full_name
    if (first_name || last_name)
      "#{first_name} #{last_name}"
    else
      email
    end
  end

end
