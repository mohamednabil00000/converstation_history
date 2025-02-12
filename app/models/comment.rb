# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :project
  belongs_to :author, class_name: "User"

  validates :content, presence: true

  scope :order_by_latest, -> { order(created_at: :desc) }
end
