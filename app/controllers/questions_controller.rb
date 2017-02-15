class QuestionsController < ApplicationController
  layout "backend"

  before_action :authenticate_user!
  before_action :set_question, only: [:edit, :update, :destroy]

  def index
    @question ||= Question.new
    @questions = current_user.questions.order(:position).all
    render :index
  end

  def edit
    index
  end

  def create
    @question = current_user.questions.build(question_params)

    if @question.save
      redirect_to questions_path, notice: "A questão foi adicionada com sucesso!"
    else
      index
    end
  end

  def update
    if @question.update(question_params)
      redirect_to questions_path, notice: "A questão foi atualizada com sucesso!"
    else
      index
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path, notice: "A questão foi removida com sucesso!"
  end

  private

  def set_question
    @question = current_user.questions.find_by_id(params[:id])

    if @question.blank?
      redirect_to root_path
      return false
    end
  end

  def question_params
    params.require(:question).permit(:statement, :position)
  end
end
