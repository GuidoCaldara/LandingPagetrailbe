# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
LOCATION = ["Albino, Bergamo, Italy", "Bergamo, Bergamo, Italy", "Milano, Mi, Italy", "Osnago, MB, Italy", "Gazzaniga, Bergamo, Italy", "Torino, TO, Italy", "Verona, VR, Itali"]
10.times do
  User.create(email: Faker::Internet.email, password: "password", username: Faker::Name.first_name, location:LOCATION.sample)
end


30.times do
  r = Run.new(
    name: Faker::FunnyName.name,
    starting_point: LOCATION.sample,
    starting_point_info: ["In centro paese", ""].sample,
    run_distance: rand(10...50),
    elevation: [200, 500, 1000, 2300, 1200, 600].sample,
    date: Date.today + rand(20...50),
    description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    user: User.all.sample
  )
  r.save
end
