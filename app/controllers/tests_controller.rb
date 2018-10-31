class TestsController < ApplicationController

  def show
  	set_test
  end

  private

  def set_test
    @test = Test.find(params[:id])
  end

end