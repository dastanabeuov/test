class User < ApplicationRecord
  
  has_many :test_passages
  has_many :tests, through: :test_passages

  #has_many :results
  #has_many :tests, through: :results

  validates :name, :email, presence: true

  def info_passing_test(level)
    tests.where(level: level)
  end

  def test_passage(test)
  	test_passages.order(id: :desc).find_by(test_id: test.id)
  end
  
end
