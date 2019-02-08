class Feedback

  include ActiveModel::Model

  attr_accessor :email, :message, :name

  validates :email, :message, :name, presence: true

end