module QuestionsHelper
  def question_form_title(question)
    if question.persisted?
    	title = question.test.title
      "Edit question for test #{title}"      
    else
      "Create new question for test #{title}"      
    end
  end
end
