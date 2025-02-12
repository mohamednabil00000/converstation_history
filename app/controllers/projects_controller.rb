# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update]

  def new
    @project = Project.new
  end

  def show; end

  def edit; end

  def index
    @projects = @current_user.projects.all.paginate(page: page_no, per_page: per_page)
  end

  def create
    result = Projects::CreateService.call(params: project_params, user: @current_user)
    respond_to do |format|
      if result.success?
        format.html { redirect_to "/projects", notice: "Project was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity, alert: result.errors }
      end
    end
  end

  def update
    respond_to do |format|
      puts "nesma", project_params
      if @project.update(project_params)
        format.html { redirect_to "/projects", notice: "Project was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity, alert: @project.errors.full_messages.join(", ") }
      end
    end
  end

  def destroy
    @project = @current_user.projects.find(params[:id])
    @project.destroy
    respond_to do |format|
      format.html { redirect_to "/projects", notice: "Project was successfully destroyed." }
    end
  end

  private

  def set_project
    @project = @current_user.projects.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description, :status)
  end
end
