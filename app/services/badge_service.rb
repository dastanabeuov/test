class BadgeService
  
  def initialize(test_passage)
    user = test_passage.user
    @badges = Badge.all.select { |b| b.find_tests.include?(test_passage.test) }
    @tests = user.test_passages.completed?.map(&:test)
  end

  def build
    @badges.select do |b|
      b.find_tests.all? { |test| @tests.include?(test) }
    end
  end

end