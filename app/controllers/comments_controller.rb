# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_project, only: %i[index destroy]

  def new
    @comment = Comment.new
  end

  def destroy
    @comment = @project.comments.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to "/projects/#{params[:project_id]}", notice: "Comment was successfully destroyed." }
    end
  end

  def index
    @comments = @project.comments.all.paginate(page: page_no, per_page: per_page)
  end

  def create
    result = Comment::CreateService.call(params: comment_params, user: @current_user)
    respond_to do |format|
      if result.success?
        format.html { redirect_to "/projects/#{comment_params[:project_id]}", notice: "Comment was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity, alert: result.errors }
      end
    end
  end

  private

  def set_project
    @project = @current_user.projects.find(params[:project_id])
  end

  def comment_params
    params.require(:comment).permit(:content, :project_id)
  end
end
