require "faker"

# TODO: Delete everything
puts "Deleting Comments..."
Comment.delete_all
puts "Deleting Posts..."
Post.delete_all
puts "Deleting Recipes..."
Recipe.delete_all
puts "Deleting Workouts..."
Workout.delete_all
puts "Deleting Users..."
User.delete_all


# TODO: Users
20.times do |x|
  puts "Creating User #{x + 1}"
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name ,
    bio: Faker::Lorem.paragraph,
    email: Faker::Internet.email,
    password: Faker::Internet.password,
  )
end

puts "Users created successfully"
# TODO: Workouts
20.times do |x|
  puts "Creating Workout #{x + 1}"
  Workout.create!(
    title: Faker::Lorem.sentence,
    description: Faker::Lorem.paragraph,
    url: Faker::Internet.url,
    difficulty: ["easy", "intermediate", "advanced"].sample,
    user: User.all.sample
  )
end
puts "Workouts created successfully"
# TODO: Recipes
20.times do |x|
  puts "Creating Recipe #{x + 1}"
  Recipe.create!(
    title: Faker::Food.dish,
    instructions: Faker::Lorem.paragraph(sentence_count: 4),
    prep_time: "#{(1..150).to_a.sample}m",
    difficulty: ["easy", "intermediate", "advanced"].sample,
    user: User.all.sample
  )
end
puts "Recipes created successfully"
# TODO: Posts
20.times do |x|
  puts "Creating Post #{x + 1}"
  Post.create!(
    content: Faker::Lorem.paragraph(sentence_count: 5),
    user: User.all.sample
  )
end
puts "Recipes created successfully"
# TODO: Comments
