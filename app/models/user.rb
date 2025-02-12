# frozen_string_literal: true

class User < ApplicationRecord
  include EmailValidator

  has_secure_password

  validates :username, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 8, maximum: 16, too_short: I18n.t("errors.messages.password_too_short"),
                                 too_long: I18n.t("errors.messages.password_too_long") }, if: :password_required?
  validates_presence_of :password_confirmation, if: :password_digest_changed?


  def self.find_authenticated(args = {})
    user = find_by(email: args[:email])
    user if user&.authenticate(args[:password])
  end

  private

  def password_required?
    password.present?
  end
end
