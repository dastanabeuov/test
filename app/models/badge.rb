class Badge < ApplicationRecord

  extend Enumerize

  enumerize :rule, in: %i(category_badge single_badge level_badge)

  before_save do
    self.image = '../../badge.png' if image.blank?
  end

  has_many :user_badges, dependent: :destroy
  has_many :users, through: :user_badges  

  validates :name, presence: true
  validates :rule, presence: true

end
