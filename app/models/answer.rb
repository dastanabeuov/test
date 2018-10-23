class Answer < ApplicationRecord
  belongs_to :question

  scope :correct, -> { where correct: true }

  validates :body, presence: true
  validate :validate_answers_for_question, on: :create

  def validate_answers_for_question
    errors.add(:question, 'У одного Вопроса может быть от 1-го до 4-х ответов.') if self.question.answers.count >= 4
  end
end
