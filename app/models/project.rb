# frozen_string_literal: true

class Project < ApplicationRecord
  belongs_to :owner, class_name: "User"

  enum status: { active: "active", archived: "archived" }

  validates :name, presence: true
  validates :status, presence: true, inclusion: { in: statuses.keys }

  scope :order_by_latest, -> { order(created_at: :desc) }
end
