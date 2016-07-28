# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Editor.create(email: "test@me.com" , password_digest: "12345")

Topic.create(name:"Election 2016")
Topic.create(name:"US News")
Topic.create(name:"Immigration")
Topic.create(name:"BlackLivesMatter")
Topic.create(name:"Breaking News")

25.times do |n|
  Story.create(name:"example#{n}")
end
