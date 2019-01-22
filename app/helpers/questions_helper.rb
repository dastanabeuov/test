module QuestionsHelper
  
  def question_form_title(question)
    title = question.test.title
    if question.persisted?
      "Edit question for test #{title}"      
    else
      "Create new question for test #{title}"      
    end
  end

end
