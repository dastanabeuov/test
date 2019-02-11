class Badge < ApplicationRecord

  extend Enumerize

  enumerize :rule, in: %i[category_badge single_badge level_badge]

  before_save do
    self.image = '../../badge.png' if image.blank?
  end  

  has_many :my_badges, dependent: :destroy
  has_many :users, through: :my_badges  

  scope :category_badge, -> { where(rule: 'category_badge') }
  scope :single_badge, -> { where(rule: 'single_badge') }
  scope :level_badge, -> { where(rule: 'level_badge') }

  validates :name, presence: true
  validates :rule, presence: true
  validate :validate_badges_by_category

  def find_tests
    case rule
    when 'category_badge'
      category = Category.find_by(title: primary_param)
      Test.all.where(category_id: category)
    when 'single_badge'
      Test.all.where(title: primary_param, level: secondary_param)
    when 'level_badge'
      Test.all.where(level: primary_param)
    end
  end

  private

  def validate_badges_by_category
    case rule
    when 'category_badge'
      errors.add(:primary_param) unless Category.exists?(title: primary_param)
    when 'single_badge'
      errors.add(:secondary_param) unless Test.exists?(title: primary_param, level: secondary_param)
    when 'level_badge'
      errors.add(:primary_param) unless Test.exists?(level: primary_param)
    end
  end  

end
