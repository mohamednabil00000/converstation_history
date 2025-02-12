# frozen_string_literal: true

require "will_paginate/array"

class ApplicationController < ActionController::Base
  include Pagination
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  protect_from_forgery prepend: true, with: :exception

  before_action :authorize

  protected

  def authorize
    unless session_valid?
      return render json: { errors: [ I18n.t("errors.messages.unauthorized") ] }, status: :unauthorized
    end

    result = Auth::AuthenticateRequestService.call(auth_header: auth_token)
    unless result.success?
      return render json: { errors: [ I18n.t("errors.messages.unauthorized") ] }, status: :unauthorized
    end

    @current_user = result.current_user
  end

  def session_valid?
    auth_token.present?
  end

  def auth_token
    session[:auth_token]
  end
end
