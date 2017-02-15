class AnswersController < ApplicationController
  layout "answers"

  before_action :set_user, only: [:new, :create, :show]

  def new
    @questions = @user.questions.order(:position).all
  end

  def create
    if params[:answers].present?
      params[:answers].each do |question_id, result|
        Answer.create! question: Question.where(id: question_id).first, result: result
      end
    end

    redirect_to finish_questionaire_path(slug: @user.slug)
  end

  private

  def set_user
    @user = User.where(slug: params[:slug]).first

    if @user.blank?
      redirect_to root_path
      return false
    end
  end
end
