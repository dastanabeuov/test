class Admin::QuestionsController < ApplicationController
  
  before_action :admin_required!  
  before_action :set_test, only: %i[new create]
  before_action :set_question, only: %i[show edit destroy update]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def show; end

  def new
    @question = @test.questions.new
  end

  def edit; end

  def create
    @question = @test.questions.new(question_params)

    if @question.save
      redirect_to [:admin, @question.test]
    else
      render :new
    end
  end

  def update
    if @question.update(question_params)
      redirect_to [:admin, @question]
    else
      render :edit
    end
  end

  def destroy
    @question.destroy

    redirect_to [:admin, @question.test]
  end

  private

  def question_params
    params.require(:question).permit(:body)
  end

  def set_test
    @test = Test.find(params[:test_id])
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def rescue_with_question_not_found
    render plain: 'This question does not exist'
  end

  def admin_required!
    redirect_to root_path unless current_user.is_a?(Admin)
  end  

end