module QuestionsHelper
  def question_form_title(record, title)
    if record.persisted?
      "Edit question for test #{ title }"      
    else
      "Create new question for test #{ title }"      
    end
  end
end
