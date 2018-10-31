module QuestionsHelper
  def question_header(record, title)
    if record.persisted?
      "Редактировать вопрос для теста #{ title }"      
    else
      "Создать новый вопрос для теста #{ title }"      
    end
  end
end
