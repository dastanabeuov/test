class Test < ApplicationRecord
  belongs_to :category
  belongs_to :user

  has_many :results
  has_many :users, through: :results
  has_many :questions, dependent: :destroy

  scope :easy_level, -> { where(level: 0..1) }
  scope :normal_level, -> { where(level: 2..4) }
  scope :hard_level, -> { where(level: 5..Float::INFINITY) }

  validates :title, :level, presence: true
  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :title, uniqueness: { scope: :level }

  def self.titles_by_category(category)
    Test.joins(:category)
    .where(category: category)
    .order(title: :desc).pluck(:title)
  end

end
