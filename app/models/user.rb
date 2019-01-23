class User < ApplicationRecord
  
  before_save { self.email = email.downcase }

  has_many :test_passages
  has_many :tests, through: :test_passages

  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
  uniqueness: { case_sensitive: false }
  has_secure_password  

  def info_passing_test(level)
    tests.where(level: level)
  end

  def test_passage(test)
  	test_passages.order(id: :desc).find_by(test_id: test.id)
  end
  
end
