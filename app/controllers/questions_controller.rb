class QuestionsController < ApplicationController
  before_action :set_test
  before_action :set_question

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def set_test
    @test = Test.find(params[:test_id])
  end

  def set_question
    Question.find(params[:id])
  end

  def new
    
  end

  def create
    @test.questions.create(question_params)

    redirect_to test_questions_path(@test)
  end

  def delete
    @question.destroy

    redirect_to test_questions_path(@test)
  end

  private

  def question_params
    params.require(:question).permit(:body)
  end

  def rescue_with_question_not_found
    render html: '<h1>Вопрос не найден</h1>'.html_safe
  end

end
