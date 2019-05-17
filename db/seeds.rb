# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

u = User.create(name: "test", email: "test@tester.com", password: "test")
p1 = Project.create(name: "my first project", user_id: u.id)
p2 = Project.create(name: "my Project", description: "one of those counting project", priority: 2, user_id: u.id)
t1 = Todo.create(task: "first action on starting the project", project_id: p1.id)
t2 = Todo.create(task: "second action on starting the project", project_id: p2.id)
t3 = Todo.create(task: "third action on starting the project", project_id: p1.id)
t4 = Todo.create(task: "fourth action on starting the project", project_id: p2.id)
t5 = Todo.create(task: "fifth action on starting the project", project_id: p1.id)