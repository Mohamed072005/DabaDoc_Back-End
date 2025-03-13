class Like
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  belongs_to :question

  validates :user_id, uniqueness: { scope: :question_id }
end