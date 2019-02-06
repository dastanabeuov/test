# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = User.create!(
  [
    { email: 'd.abeuov9@gmail.com', password: 'A-z123123', 
      password_confirmation: 'A-z123123', first_name: 'Dastan', 
      last_name: 'Abeuov', type: 'Admin' },
    { email: 'example@example.org', password: 'A-z123123', password_confirmation: 'A-z123123' }
    ]
  )

categories = Category.create!(
  [
    { title: 'frontend' },
    { title: 'backend' },
    { title: 'machine learning' }
    ]
  )

tests = Test.create!(
  [
    { title: 'Ruby', level: 1, category_id: categories[1].id, user_id: User.first.id },
    { title: 'RoR', level: 2, category_id: categories[1].id, user_id: User.first.id },
    { title: 'HTML5', level: 3, category_id: categories[0].id, user_id: User.first.id },
    { title: 'OS+nginx+passenger+sql+RoR+redis', level: 4, category_id: categories[2].id, user_id: User.first.id }
  ]

)

questions = Question.create!(
  [
    { body: 'Who is author lang Ruby?', test_id: tests[0].id },
    { body: 'What language is written in RubyonRails?', test_id: tests[1].id },
    { body: 'What is the method decription on HTML5?', test_id: tests[2].id },
    { body: 'Who is create nginx+passenger?', test_id: tests[3].id }
  ]
)

answers = Answer.create!(
  [
    { body: 'Matz', correct: true, question_id: questions[0].id },
    { body: 'Ruby', correct: true, question_id: questions[1].id },
    { body: 'This method information write sample text on site', correct: true, question_id: questions[2].id },
    { body: 'Igor Sysoev', correct: true, question_id: questions[3].id },
    { body: 'David H.H', correct: false, question_id: questions[0].id },
    { body: 'JavaScript', correct: false, question_id: questions[1].id },
    { body: 'Tis method from form authod write', correct: false, question_id: questions[2].id },
    { body: 'Alexander Shults', correct: false, question_id: questions[3].id }
  ]
)
