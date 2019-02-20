class TestPassage < ApplicationRecord
  
  PASS_TEST_THRESHOLD = 85
  
  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :before_validation_set_next_question
  before_save :before_save_set_result

  scope :last_test_entry, ->(test) { where(test_id: test.id).last }

  scope :success, -> { where('result > :pass_test_threshold', 
                  pass_test_threshold: PASS_TEST_THRESHOLD) }

  def timer_off?
    test.timer?
    Time.current > timer_up
  end

  def timer_down
    (timer_up - Time.current).to_i
  end

  def completed?
    current_question.nil?
  end
  
  def accept!(answer_ids)
    if timer_off?
      completed!
      save!
    else
      self.correct_questions += 1 if correct_answer?(answer_ids)
      save!
    end
  end

  def test_passed?
    values_for_result.floor >= PASS_TEST_THRESHOLD
  end  

  def current_question_number
    test.questions.where('id < ?', current_question.id).count + 1
  end

  def values_for_result
    (correct_questions / test.questions.count * 100)
  end  

  private

  def completed!
    current_question = nil
  end  
  
  def timer_up
    created_at + test.timer.minutes
  end    

  def before_save_set_result
    self.result = values_for_result
  end  

  def before_validation_set_next_question
    self.current_question = next_question
  end

  def correct_answer?(answer_ids)
    correct_answers.ids.sort == Array(answer_ids).map(&:to_i).sort
  end

  def correct_answers
    current_question.answers.correct
  end

  def next_question
    return self.current_question = test.questions.first if test.present? && current_question.nil?
    self.current_question = test.questions.order(:id).where('id > ?', current_question.id).first
  end    

end
