# frozen_string_literal: true

module EmailValidator
  extend ActiveSupport::Concern

  included do
    validates :email, format: { with: /\A.+@.+\.\w{2,6}\Z/, message: I18n.t("errors.messages.invalid_email") },
                      if: :email_required?

    private

    def email_required?
      email.present?
    end
  end
end
