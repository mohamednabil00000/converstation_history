# frozen_string_literal: true

class Projects::CreateService
  Result = ImmutableStruct.new(:project, :success?, :errors)

  def self.call(params:, user:)
    new(params, user).call
  end

  def call
    project = user.projects.new(params)
    unless project.save
      return Result.new(errors: project.errors.full_messages.join(", "), success: false)
    end

    Result.new(project:, success: true)
  end

  private

  attr_reader :params, :user

  def initialize(params, user)
    @params = params
    @user = user
  end
end
