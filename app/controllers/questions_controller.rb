class QuestionsController < ApplicationController
  before_action :set_test, only: [:index, :new, :create]
  before_action :set_question, only: [:show, :delete]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def index
    render 'questions/index', layout: false
  end

  def show; end

  def new
    render 'questions/new', layout: false
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

  def set_question
    @question = Question.find(params[:id])
  end

  def set_test
    @test = Test.find(params[:test_id])
  end

  def question_params
    params.require(:question).permit(:body)
  end

  def rescue_with_question_not_found
    render html: '<h1>Вопрос не найден</h1>'.html_safe
  end

end
