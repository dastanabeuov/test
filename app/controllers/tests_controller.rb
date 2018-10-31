class TestsController < ApplicationController
  before_action :set_test

  def show; end

  private

  def set_test
    @test = Test.find(params[:id])
  end

end