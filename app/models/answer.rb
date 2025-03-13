class Answer
  include Mongoid::Document
  include Mongoid::Timestamps

  field :content, type: String

  belongs_to :user
  belongs_to :question

  validates :content, presence: true
end