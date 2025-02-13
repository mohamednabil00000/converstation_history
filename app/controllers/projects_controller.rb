# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]
  before_action :authorize_user!, only: %i[edit update destroy]

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/:id
  def show
    @comments = @project.comments.order_by_latest.includes(:author).paginate(page: page_no, per_page: per_page)
  end

  # GET /projects/:id/edit
  def edit; end

  # GET /projects
  def index
    @projects = Project.includes(:owner).paginate(page: page_no, per_page: per_page)
  end

  # POST /projects
  def create
    result = Projects::CreateService.call(params: project_params, user: @current_user)
    respond_to do |format|
      if result.success?
        format.html { redirect_to "/projects", notice: I18n.t("projects.create.success") }
      else
        format.html { render :new, status: :unprocessable_entity, alert: result.errors }
      end
    end
  end

  # PATCH/PUT /projects/:id
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to "/projects", notice: I18n.t("projects.update.success") }
      else
        format.html { render :edit, status: :unprocessable_entity, alert: @project.errors.full_messages.join(", ") }
      end
    end
  end

  # DELETE /projects/:id
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to "/projects", notice: I18n.t("projects.destroy.success") }
    end
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def authorize_user!
    unless @project.owner.id == @current_user.id
      respond_to do |format|
        format.html do
          redirect_to "/projects", alert: I18n.t("projects.unauthorized")
        end
      end
      return false
    end

    true
  end

  def project_params
    params.require(:project).permit(:name, :description, :status)
  end
end
