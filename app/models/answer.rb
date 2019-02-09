class Answer < ApplicationRecord
  
  belongs_to :question

  scope :correct, -> { where correct: true }

  validates :body, presence: true
  validate :validate_answers_for_question, on: :create

  def validate_answers_for_question
    errors.add(:question_id) if question.answers.count >= 4 
  end

end
