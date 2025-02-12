# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    name { Faker::Company.name }
    status { Project.statuses.keys.sample }
  end
end
