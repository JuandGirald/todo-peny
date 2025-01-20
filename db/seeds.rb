# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Task.create(title: 'Task 1', start_time: DateTime.now, end_time: DateTime.now + 1.hour)
Task.create(title: 'Task 2', start_time: DateTime.now + 1.hour, end_time: DateTime.now + 2.hours)
Task.create(title: 'Task 3', start_time: DateTime.now + 2.hours, end_time: DateTime.now + 3.hours)
