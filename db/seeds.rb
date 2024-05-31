# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

USER_COUNT = 4

USER_COUNT.times {
  User.create(
    name: Faker::Name.name,
    birthday: Faker::Date.birthday,
    email: Faker::Internet.email,
    password: Faker::Internet.password
  )
}

Group.create([
  {name: "aqua"},
  {name: "am"},
  {name: "boys"},
  {name: "exm"}
])

GroupMember.create([
  {member: User.first, group_id: Group.first.id},
  {member: User.second, group_id: Group.first.id},
  {member: User.third, group_id: Group.first.id},

  {member: User.first, group_id: Group.second.id},
  {member: User.second, group_id: Group.second.id},

  {member: Group.second, group_id: Group.first.id},
  {member: Group.third, group_id: Group.first.id}
])

questions = Question.create([
  {questions_count: 3,
   questions: [
     {"id" => "1", "number" => 1, "type" => "text", "text" => "fav artist?", "required" => true},
     {"id" => "2", "number" => 2, "type" => "text", "text" => "fav song?", "required" => true},
     {"id" => "3", "number" => 3, "type" => "integer", "text" => "how many times do you listening this song?"}
   ]},
  {questions_count: 2,
   questions: [
     {"id" => "1", "number" => 1, "type" => "text", "text" => "Do you like Honda Civic Type R?"},
     {"id" => "2", "number" => 2, "type" => "checkbox", "text" => "I have a Honda Civic Type R"}
   ]}
])

surveys = Survey.create([
  {name: "Ask me about Honda", question_mongo_id: questions.second.id.to_s},
  {name: "About music", question_mongo_id: questions.first.id.to_s}
])

Permission.create([
  {owner: User.first, entity: Survey.first, role_id: Role.first.id},
  {owner: User.second, entity: Survey.first, role_id: Role.first.id},
  {owner: User.second, entity: Survey.second, role_id: Role.first.id},

  {owner: Group.first, entity: Survey.first, role_id: Role.second.id},
  {owner: Group.first, entity: Survey.second, role_id: Role.first.id},

  {owner: User.second, entity: Group.first, role_id: Role.first.id},
  {owner: User.first, entity: Group.first, role_id: Role.second.id},

  {owner: Group.first, entity: Group.second, role_id: Role.second.id}
])

User.all.each do |user|
  answer_data = AnswerDatum.create(
    answers_count: 2,
    answer_data: [{number: 1, result: ["Yes", "no", "idk, man 4r"].sample}, {number: 2, result: [true, false].sample.to_s}]
  )
  Answer.create(user: user, survey: surveys.first, answer_mongo_id: answer_data.id)
end

[
  ["Lil Peep", "Honestly"],
  ["Suicideboys", "O Pana!"],
  ["Yung Lean", "Agony"]
].each do |artist, song|
  answer_data = AnswerDatum.create(
    answers_count: 3,
    answer_data: [{"number" => 1, "result" => artist}, {"number" => 2, "result" => song}, {"number" => 3, "result" => rand(1..20).to_s}],
    answer_time: rand(30..700).to_s
  )
  Answer.create(user: User.all[rand(4)], survey: surveys.last, answer_mongo_id: answer_data.id)
end

answer_data = AnswerDatum.create(
  answers_count: 2,
  answer_data: [{"number" => 1, "result" => "Kanye West"}, {"number" => 2, "result" => "Donda chant"}],
  answer_time: "80"
)
Answer.create(user: User.all[rand(4)], survey: surveys.last, answer_mongo_id: answer_data.id)

FieldType.create([{name: "text"}, {name: "checkbox"}, {name: "radio"}])
