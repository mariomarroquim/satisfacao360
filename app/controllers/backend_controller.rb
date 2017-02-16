class BackendController < ApplicationController
  layout "backend"

  before_action :authenticate_user!

  def start
    if current_user.questionaire_published? || current_user.answers.exists?
      index
    elsif current_user.needs_setup?
      redirect_to edit_user_path(current_user)
    else
      redirect_to questions_path
    end
  end

  def index
    @answers_by_result = []
    @answers_by_question_and_result = []

    Answer.results.each do |result_name, result_value|
      item_name = Answer::RESULT_NAMES[result_value]
      @answers_by_result << [item_name, current_user.answers.send("#{result_name}").count]
      @answers_by_question_and_result << {name: item_name, data: current_user.answers.send("#{result_name}").joins(:question).group("questions.statement").count.to_a}
    end

    render :index
  end

  def answers_by_result_and_month
    output = []

    Answer.results.each do |result_name, result_value|
      data = current_user.answers.send("#{result_name}")

      data = data.where(question_id: params[:question_id]) if params[:question_id].present?

      output << {name: Answer::RESULT_NAMES[result_value], data: data.group_by_month(:created_at, format: "%b/%y").count.to_a}
    end

    render json: output
  end
end
