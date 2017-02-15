class Question < ActiveRecord::Base
  belongs_to :user

  has_many :answers, dependent: :destroy

  before_validation :set_position

  validates :user, :statement, :position, presence: true
  validates :statement, uniqueness: {scope: :user_id}, allow_blank: true
  validates :position, numericality: {only_integer: true, greater_than: 0}, allow_blank: true

  protected

  def set_position
    self.position = user.questions.count + 1 if user.present? && position.nil?
  end
end
