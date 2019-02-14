class TestPassagesController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_test_passage, only: %i[show update result gist]

  def show; end

  def result; end

  def update
    @test_passage.accept!(params[:answer_ids])
    
    if @test_passage.completed?
      @user_badges = BadgeService.new(current_user, @test_passage).build
      current_user.badges << @user_badges
      TestsMailer.completed_test(@test_passage).deliver_now
      redirect_to result_test_passage_path(@test_passage)
    else
      render :show
    end
  end

  def gist
    service = GistQuestionService.new(@test_passage.current_question)
    git_response = service.call

    if service
      Gist.create!(question: @test_passage.current_question,
                                user: current_user,      
                                gist_url: url(git_response))
      flash[:notice] = t('.success', link: url(git_response))
    else
      flash[:alert] = t('.failure')
    end

    redirect_to @test_passage
  end
  
  private  

  def url(path)
    path.html_url
  end

  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
  end
end