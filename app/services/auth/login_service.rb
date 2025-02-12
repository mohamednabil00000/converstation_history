# frozen_string_literal: true

class Auth::LoginService
  include JsonWebToken

  Result = ImmutableStruct.new(:current_user, :token, :success?, :errors)

  def self.call(email:, password:)
    new(email, password).call
  end

  def call
    current_user = User.find_authenticated(email:, password:)
    return Result.new(errors: [ I18n.t("errors.messages.wrong_email_or_password") ]) unless current_user

    token = jwt_encode(user_id: current_user.id)
    Result.new(current_user:, token:, success: true)
  end

  private

  attr_reader :email, :password

  def initialize(email, password)
    @email = email
    @password = password
  end
end
