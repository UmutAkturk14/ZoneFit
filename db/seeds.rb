require "faker"
require "google/apis/youtube_v3"
youtube = Google::Apis::YoutubeV3::YouTubeService.new
youtube.key = ENV["YouTubeAPIKey"]

def create_workouts(arr)
  arr.each do |element|
    youtube = Google::Apis::YoutubeV3::YouTubeService.new
    youtube.key = ENV["YouTubeAPIKey"]
    response = youtube.list_searches("snippet", q: "#{element}", max_results: 50, type: "video")
    response.items.each do |r|
      Workout.create!(
        title: r.snippet.title,
        description: r.snippet.description,
        url: r.id.video_id,
        user: User.all.sample
      )
    end
    puts "Workout added successfully"
  end
end

workouts = ["workout", "dumbbell workout", "kettlebell workout", "jump rope workout",
            "no equipment workout", "chest workout", "legs workout", "shoulder workout", "back workout", "cardio workout", "strength workout"]

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

create_workouts(workouts)
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



# TODO: Workout instances
