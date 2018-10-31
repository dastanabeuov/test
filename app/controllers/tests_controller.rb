class TestsController < ApplicationController

  def index
  	@tests = Test.all
  end

  def show
  	set_test
  end

  private

  def set_test
    @test = Test.find(params[:id])
  end

end