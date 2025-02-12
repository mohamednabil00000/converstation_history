# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authorize, only: %i[new create]

  def new; end

  def create
    result = Auth::LoginService.call(email: login_params[:email], password: login_params[:password])
    if result.success?
      session[:auth_token] = result.token
      redirect_to "/projects"
    else
      flash[:notice] = I18n.t("errors.messages.wrong_email_or_password")
      redirect_to "/"
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
