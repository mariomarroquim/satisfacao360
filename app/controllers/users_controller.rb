class UsersController < ApplicationController
  layout "backend"

  before_action :authenticate_user!
  before_action :set_user, only: [:edit, :update, :publish, :unpublish, :destroy]

  def edit
    if params[:only_account].blank? && current_user.needs_setup?
      flash.now[:info] ||= "Olá! Tudo bom? Primeiro vamos realizar a configuração inicial da sua conta."
    end
  end

  def update
    if @user.update(user_params)
      if params[:only_account].present? || current_user.answers.exists?
        notice = "A sua conta foi atualizada com sucesso!" if params[:only_account].present?
        notice = "A configuração inicial foi realizada com sucesso!" if params[:only_account].blank?
        redirect_to edit_user_path(@user, only_account: params[:only_account]), notice: notice
      else
        flash[:info] = "Tudo certo. Agora, por favor, revise as questões e publique o questionário para começar a receber respostas."
        redirect_to questions_path
      end
    else
      render :edit
    end
  end

  def publish
    @user.update_attributes! questionaire_published: true
    redirect_to questions_path, notice: "Tudo certo. O seu questionário está publicado! <b>Acesso: <a href='#{view_questionaire_path(slug: @user.slug, only_path: false)}'>#{view_questionaire_path(slug: @user.slug, only_path: false)}</a></b>."
  end

  def unpublish
    @user.update_attributes! questionaire_published: false
    redirect_to questions_path, notice: "Tudo certo. O seu questionário não está publicado!"
  end

  def destroy
    @user.destroy
    redirect_to root_url, notice: "A sua conta foi removida com sucesso!"
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :company, :telephone, :questionaire_header, :questionaire_footer, :questionaire_published, :logo)
  end
end
