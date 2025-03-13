class Question
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :content, type: String
  field :location, type: Array

  belongs_to :user
  has_many :answers

  validates :title, :content, :location, presence: true
end
