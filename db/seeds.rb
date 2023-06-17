# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "json"
require "open-uri"

puts "Destroying all recipes"
Recipe.destroy_all

puts "Creating new recipes.."

url =

20.times do
  Recipe.create!(
    title: Faker::,
    ingredients: ,
    prep_time: ,
    instructions: ,
    difficulty: ["Easy", "Medium", "Hard"].sample
    user: User.sample
  )
end
