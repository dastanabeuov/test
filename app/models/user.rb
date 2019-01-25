class User < ApplicationRecord

  devise :database_authenticatable,
         :registerable,
         :recoverable, 
         :rememberable, 
         :validatable,
         :confirmable
  
  has_many :test_passages
  has_many :tests, through: :test_passages
  has_many :author_tests, class_name: 'Test', foreign_key: :user_id

  VALID_EMAIL_REGEX = /.+@.+\..+/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }

  def info_passing_test(level)
    tests.where(level: level)
  end

  def test_passage(test)
  	test_passages.order(id: :desc).find_by(test_id: test.id)
  end
  
end
