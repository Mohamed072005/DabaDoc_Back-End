class Question
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :content, type: String
  field :location, type: Hash

  belongs_to :user
  has_many :answers
  has_many :likes

  validates :title, :content, :location, presence: true
end
