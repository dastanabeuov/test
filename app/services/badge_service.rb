class BadgeService
  
  def initialize(user, test_passage)
    @badge_user = user
    @test_passage = test_passage
  end

  def build
    @badges = Badge.all.select { |badge| send("#{badge.rule}", badge.primary_param) }
  end

  private

  def category_badge(category)
    tests_by_category = Test.by_category(category).ids.map(&:to_s)
    one_current_category_tests = badge_user.test_passages.where(test_id: tests_by_category).pluck(:test_id).map(&:to_s)
    tests_by_category.sort == one_current_category_tests.sort
  end

  def single_badge(param)
    @badge_user.test_passages.successfull.where(test: test_passage.test)
  end

  def level_badge(level)
    tests_by_level = Test.by_current_level(level).ids.map(&:to_s)
    all_current_level_tests = badge_user.test_passages.where(test_id: tests_by_level).pluck(:test_id).map(&:to_s)
    tests_by_level.sort == all_current_level_tests.sort
  end
  
end