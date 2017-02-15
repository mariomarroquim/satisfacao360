class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question

  enum result: [:poor, :fair, :good]
  RESULT_NAMES = %w(Insatisfeito(a) Neutro(a) Satisfeito(a))

  before_validation :set_user

  validates :user, :question, :result, presence: true

  protected

  def set_user
    self.user ||= question.user if question.present?
  end
end
