class BadgeService
  
  def initialize(user, test_passage)
    @badge_user = user
    @test_passage = test_passage
  end

  def build
    Badge.all.select { |badge| send("#{badge.rule}?", badge.primary_param) }
  end

  private

  def category_badge?(category)
    if @test_passage.test.category == category
      tests_by_category = Test.by_category(category)
      one_current_category_tests = @badge_user.test_passages.where(test_id: tests_by_category)
      tests_by_category.sort == one_current_category_tests.sort
    end
  end

  def single_badge?(param)
    @badge_user.test_passages.success.where(test: @test_passage.test)
  end

  def level_badge?(level)
    if @test_passage.test.level == level
      tests_by_level = Test.by_current_level(level)
      all_current_level_tests = @badge_user.test_passages.where(test_id: tests_by_level)
      tests_by_level.ids.sort == all_current_level_tests.ids.sort
    end
  end  
  
end