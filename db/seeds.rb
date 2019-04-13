# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Contact.destroy_all
Reminder.destroy_all

u1 = User.create(first_name: "Joan", last_name: "Archie", username: "jojo", email: "jojo@validemail.com", avatar: "https://ayogo.com/wp-content/uploads/2015/06/jp-avatar-placeholder.png", password: 'test')
u2 = User.create(first_name: "Diane", last_name: "Lane", username: "deedee", email: "diane@validemail.com", avatar: "https://ayogo.com/wp-content/uploads/2015/06/jp-avatar-placeholder.png", password: 'test')
u3 = User.create(first_name: "Paula", avatar: "https://ayogo.com/wp-content/uploads/2015/06/jp-avatar-placeholder.png", password: 'test')

c1 = Contact.create(requestor: u1, requested: u2)
c2 = Contact.create(requestor: u1, requested: u3)

Reminder.create(msg: "Call Diane", start_date: DateTime.new(2019, 4, 8), interval: 1, period: 'weekly', end_date: DateTime.new(2024, 12, 31), contact: c1)
Reminder.create(msg: "Diane's Birthday", start_date: DateTime.new(2019, 4, 9), interval: 1, period: 'weekly', end_date: DateTime.new(2024, 12, 31), contact: c1)
Reminder.create(msg: "Lunch Date with Paula", start_date: DateTime.new(2019, 4, 12), interval: 1, period: 'weekly', end_date: DateTime.new(2024, 12, 31), contact: c2)
Reminder.create(msg: "Paula's Birthday", start_date: DateTime.new(2019, 4, 8), interval: 1, period: 'yearly', end_date: DateTime.new(2024, 12, 31), contact: c2)
