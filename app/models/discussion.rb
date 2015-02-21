class Discussion < ActiveRecord::Base
  has_many :comments, as: :commentable, dependent: :destroy #polymorphic association
end
