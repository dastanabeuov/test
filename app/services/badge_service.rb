class BadgeService
  
  def initialize(test_passage)
    @test_passage = test_passage
    @test = test_passage.test
    @user = test_passage.user
  end

  def build
    Badge.all.each do |badge|
      case badge.rule
      when 'category_badge'
        add(badge) if category_badge?(badge.primary_param)
      when 'single_badge'
        add(badge) if single_badge?
      when 'level_badge'
        add(badge) if level_badge?(badge.primary_param.to_i)
      end
    end
  end

  private

  def add(badge)
    @user.badges << badge
  end  

  def category_badge?(category)
    @test_passage.test_passed? && @test.category.title == category
    tests_by_category = Test.by_category(category).ids
    one_current_category_tests = @user.test_passages.success.where(test_id: tests_by_category).pluck(:test_id)
    tests_by_category.sort == one_current_category_tests.sort
  end

  def single_badge?
    @test_passage.test_passed? && @user.tests.where(id: @test.id).count == 1
  end

  def level_badge?(level)
    @test_passage.test_passed? && @test.level == level
    tests_by_level = Test.by_current_level(level).ids
    all_current_level_tests = @user.test_passages.success.where(test_id: tests_by_level).pluck(:test_id)
    tests_by_level.sort == all_current_level_tests.sort
     
  end  
  
end