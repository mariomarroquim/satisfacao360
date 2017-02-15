# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create! email: "mariomarroquim@gmail.com", password: "12345678", password_confirmation: "12345678"

1_500.times do
  Answer.create! question: Question.order("random()").first, result: Answer.results.keys[0], created_at: eval("Time.now - #{Kernel.rand(13)}.month")
end

1_200.times do
  Answer.create! question: Question.order("random()").first, result: Answer.results.keys[1], created_at: eval("Time.now - #{Kernel.rand(13)}.month")
end

1_300.times do
  Answer.create! question: Question.order("random()").first, result: Answer.results.keys[2], created_at: eval("Time.now - #{Kernel.rand(13)}.month")
end
