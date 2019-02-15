class BadgeService
  
  def initialize(current_user, test_passage)
    @test_passage = test_passage
    @test = test_passage.test
    @user = current_user
  end

  def build
    Badge.all.select { |badge| send("#{badge.rule}?", badge.primary_param) }
  end

  private

  def category_badge?(category)
    return false if @test.category.title == category
    tests_category = Test.by_category(category).ids
    current_category_tests = @user.test_passages.where(test_id: tests_category).pluck(:test_id)
    tests_category.sort == current_category_tests.sort
  end

  def level_badge?(level)
    return false if @test.level == level
    tests_level = Test.by_level(level).ids
    current_level_tests = @user.test_passages.where(test_id: tests_level).pluck(:test_id)
    tests_level.sort == current_level_tests.sort
  end

  def single_badge?(param)
    @test_passage.test_passed? && @user.tests.where(id: @test.id).count == 1
  end
  
end