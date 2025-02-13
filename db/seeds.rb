# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

user1 = User.create!(username: 'Manjaree', email: 'manjaree@gmail.com', password: '12345678', password_confirmation: '12345678')
user2 = User.create!(username: 'Say', email: 'say@gmail.com', password: '12345678', password_confirmation: '12345678')

project1 = Project.create!(name: 'Project 1', status: 'active', owner: user1, description: 'Description 1')
project2 = Project.create!(name: 'Project 2', status: 'archived', owner: user2, description: 'Description 2')

comment1 = Comment.create!(content: 'Comment 1', author: user1, project: project1)
comment2 = Comment.create!(content: 'Comment 2', author: user2, project: project1)
comment3 = Comment.create!(content: 'Comment 3', author: user1, project: project2)
comment4 = Comment.create!(content: 'Comment 4', author: user2, project: project2)
