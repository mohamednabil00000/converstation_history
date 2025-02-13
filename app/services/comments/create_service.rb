# frozen_string_literal: true

class Comments::CreateService
  Result = ImmutableStruct.new(:comment, :success?, :errors)

  def self.call(params:, user:)
    new(params, user).call
  end

  def call
    comment = user.comments.new(params)
    unless comment.save
      return Result.new(errors: comment.errors.full_messages.join(", "), success: false)
    end

    Result.new(comment:, success: true)
  end

  private

  attr_reader :params, :user

  def initialize(params, user)
    @params = params
    @user = user
  end
end
