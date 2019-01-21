class TestPassage < ApplicationRecord
  
  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :before_validation_set_next_question
  before_validation :before_validation_set_first_question, on: :create
  
  scope :last_test_entry, ->(test) { where(test_id: test).last }

  PASS_TEST_THRESHOLD = 85

  def completed?
    current_question.nil?
  end
  
  def accept!(answer_ids)
	  if correct_answer?(answer_ids)
	    self.correct_questions += 1
	  end
	  self.current_question = next_question
	  save!
  end

  def completed?
    current_question.nil?
  end

  def test_passed?
    (correct_questions / test.questions.count * 100).floor >= PASS_TEST_THRESHOLD
  end

  def current_question_number
    test.questions.index(current_question) + 1
  end

  private

  def before_validation_set_next_question
    return self.current_question = test.questions.first if test.present? && current_question.nil?
    self.current_question = test.questions.order(:id).where('id > ?', current_question.id).first
  end

  def before_validation_set_first_question
  	self.current_question = test.questions.first if test.present?
  end

  def correct_answer?(answer_ids)
  	correct_answers_count = correct_answers.count
    (correct_answers_count == correct_answers.where(id: answer_ids).count) &&
    correct_answers_count == answer_ids.count
  end

  def correct_answers
    current_question.answers.correct
  end

  def next_question
  	test.questions.order(:id).where('id > ?', current_question.id).first
  end

end
