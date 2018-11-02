class QuestionsController < ApplicationController
  before_action :set_test, only: [:index, :new, :create]
  before_action :set_question, only: [:show, :delete]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def index; end

  def show; end

  def edit; end

  def new; end

  def create
    @question = @test.questions.new(question_params)

    if @question.save
      redirect_to test_path(@test)
    else 
      render :new
    end
  end

  def update
    @question = Question.find(params[:id])

    if @question.update question_params
      redirect_to test_path(@question.test)
    else 
      render :edit
    end
  end

  def destroy
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
