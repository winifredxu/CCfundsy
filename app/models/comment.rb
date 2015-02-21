class Comment < ActiveRecord::Base
  # polymorphic association
  belongs_to :commentable, polymorphic: true,
              touch: true  # to expire the cache on the commentable
  validates :body, presence: true
end
