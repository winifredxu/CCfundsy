class Campaign < ActiveRecord::Base
  include AASM  # add Finite State Machines to Ruby classes

  attr_accessor :notify_admin  # add a non-DB field


  geocoded_by :address #Geocode
  after_validation :geocode

  belongs_to :user

  has_many :categorizations, dependent: :destroy #many-to-many association
  has_many :categories, through: :categorizations
  
  has_many :comments, as: :commentable, dependent: :destroy #polymorphic association

  has_many :reward_levels, dependent: :destroy #nested attributes
  accepts_nested_attributes_for :reward_levels, 
        reject_if: lambda { |x| 
          x[:amount].blank? &&
          x[:title].blank? &&
          x[:body].blank? &&
          x[:quantity].blank?
        }, allow_destroy: true #allows the ability to delete nested attributes

  validates :title, presence: true, uniqueness: {:scope => :description}
  validates :description, presence: true
  validates :goal, presence: true, numericality: {greater_than_or_equal_to: 10}
  validates :reward_levels, presence: true
  
  scope :published, -> { where(aasm_state: :published) }   #FSM transitions
  
  delegate :full_name, :first_name, :last_name, to: :user, prefix: true  #prefix gives user_full_name

  #def full_name
  #  user.full_name
  #end

  # define the Finite State Machine's list of states
  aasm do
    state :draft, initial: true
    state :published
    state :cancelled
    state :funded
    state :unfunded
    state :paused

    event :publish do
      transitions from: :draft, to: :published
    end
    event :cancel do
      transitions from: [:published, :funded, :paused], to: :cancelled
    end
    event :fund do
      transitions from: :published, to: :funded
    end
    event :unfund do
      transitions from: :published, to: :unfunded
    end
    event :pause do
      transitions from: :published, to: :paused
    end
    event :unpause do
      transitions from: :paused, to: :published
    end
  end

  def self.recent(count)
    order("created_at DESC").limit(count)
  end

end
