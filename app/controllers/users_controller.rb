
# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]

  def index
    @users = User.all.paginate(page: page_no, per_page: per_page)
  end

  def new; end

  def show; end

  def edit; end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to "/users", notice: "User was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity, alert: @user.errors.full_messages.join(", ") }
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email)
  end
end
