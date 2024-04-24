# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

USER_COUNT = 4

USER_COUNT.times {
  User.create({
    name: Faker::Name.name,
    birthday: Faker::Date.birthday,
    email: Faker::Internet.email,
    password: Faker::Internet.password
  })
}

Role.create([{name: Role::ADMIN}, {name: Role::MANAGER}, {name: Role::GUEST}])

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

Question.create([
  {"questions_count" => 2,
   "1" => {
     "type" => "text",
     "question" => "Do you like Honda Civic Type R?"
   },
   "2" => {
     "type" => "checkbox",
     "question" => "I have a Honda Civic Type R"
   }},
  {"questions_count" => 1,
   "1" => {
     "type" => "text",
     "question" => "What do you prefer: Africa or China?"
   }}
])

Survey.create([
  {name: "Ask me about Honda", question_mongo_id: Question.first.id.to_s},
  {name: "Fav country", question_mongo_id: Question.last.id.to_s}
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
  answer_data = AnswerDatum.create(questions_count: 2, field_1: ["Yes", "no", "idk, man 4r"].sample, field_2: [true, false].sample)
  Answer.create(user: user, survey: Survey.first, answer_mongo_id: answer_data.id)
end

User.all[1..USER_COUNT].each do |user|
  answer_data = AnswerDatum.create(questions_count: 1, field_1: ["Africa", "China", "Brasilia)"].sample)
  Answer.create(user: user, survey: Survey.second, answer_mongo_id: answer_data.id)
end

FieldType.create([{name: "text"}, {name: "checkbox"}, {name: "radio"}])
