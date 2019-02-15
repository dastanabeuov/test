class Test < ApplicationRecord
  
  belongs_to :category
  belongs_to :author, class_name: 'User', foreign_key: :user_id

  has_many :test_passages, dependent: :destroy
  has_many :users, through: :test_passages
  has_many :questions, dependent: :destroy
  #has_many :results
  #has_many :users, through: :results

  scope :easy_level, -> { where(level: 0..1) }
  scope :normal_level, -> { where(level: 2..4) }
  scope :hard_level, -> { where(level: 5..Float::INFINITY) }

  scope :by_current_level, ->(level) { where(level: level) }
  scope :by_category, ->(category) { joins(:category).where(categories: { title: category }) }

  validates :title, :level, presence: true
  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :title, uniqueness: { scope: :level }

  def self.titles_by_category(category)
    Test.joins(:category)
    .where(category: category)
    .order(title: :desc).pluck(:title)
  end

end
