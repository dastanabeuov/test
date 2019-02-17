class Badge < ApplicationRecord

  extend Enumerize

  enumerize :rule, in: %i(category_badge level_badge single_badge)
  
  before_save do
    self.image ||= '../../badge.png'
  end

  has_many :user_badges, dependent: :destroy
  has_many :users, through: :user_badges  

  validates :name, :rule, presence: true

end
