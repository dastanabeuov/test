class Answer < ApplicationRecord
  
  belongs_to :question

  scope :correct, -> { where correct: true }

  validates :body, presence: true
  validate :validate_answers_for_question, on: :create

  def validate_answers_for_question
    errors.add(:question) if self.question.answers.count >= 4
  end

end
