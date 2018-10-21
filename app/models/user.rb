class User < ApplicationRecord
  has_many :results

  has_many :tests, through: :results

  validates :name, :email, presence: true

  def info_passing_test(level)
    Test.joins(:results)
    .where(["results.user_id = ? AND tests.level = ?", self.id, level])
  end
end
