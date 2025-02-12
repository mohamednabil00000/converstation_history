# frozen_string_literal: true

class Auth::AuthenticateRequestService
  include JsonWebToken

  Result = ImmutableStruct.new(:current_user, :success?)

  def self.call(auth_header:)
    new(auth_header).call
  end

  def call
    return Result.new(success: false) unless auth_header

    decoded = jwt_decode(auth_header.split.last)
    current_user = User.find(decoded[:user_id])
    return Result.new(success: false) unless current_user

    Result.new(current_user:, success: true)
  rescue JWT::ExpiredSignature, JWT::DecodeError
    Result.new(success: false)
  end

  private

  attr_reader :auth_header

  def initialize(auth_header)
    @auth_header = auth_header
  end
end
