require "faker"
require "json"
require "open-uri"
require "google/apis/youtube_v3"
youtube = Google::Apis::YoutubeV3::YouTubeService.new
youtube.key = ENV["YouTubeAPIKey"]

def create_workouts(arr)
  arr.each do |element|
    youtube = Google::Apis::YoutubeV3::YouTubeService.new
    youtube.key = ENV["YouTubeAPIKey"]
    response = youtube.list_searches("snippet", q: "#{element}", max_results: 5, type: "video")
    response.items.each do |r|
      video_details = youtube.list_videos("snippet", id: r.id.video_id)

      Workout.create!(
        title: r.snippet.title,
        description: video_details.items.first.snippet.description,
        url: r.id.video_id,
        # ! We might need to remove users...
        user: User.all.sample,
        tag: video_details.items.first.snippet.tags,
        thumbnail: r.snippet.thumbnails.high.url
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
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    bio: Faker::Lorem.paragraph,
    email: Faker::Internet.email,
    password: Faker::Internet.password,
    location: Faker::Address.country
  )
end

puts "Users created successfully"
# TODO: Workouts UNCOMMENT THE FOLLOWING CODE:

create_workouts(workouts)
puts "Workouts created successfully"

# TODO: Recipes API data
url = "https://www.themealdb.com/api/json/v1/1/random.php"

30.times do
  var = URI.open(url).read
  info = JSON.parse(var)
  n = 1
  # puts info["meals"][0]["strIngredient"+"#{n}"]
  ingredient = ""
  while info["meals"][0]["strIngredient"+"#{n}"].present? && info["meals"][0]["strIngredient"+"#{n}"] != ""
    ingredient += info["meals"][0]["strIngredient"+"#{n}"] + ","
    n += 1
  end
  image = ""
  if info["meals"][0]["strMealThumb"] != nil
    image = info["meals"][0]["strMealThumb"]
  else
    image = ""
  end
  Recipe.create!(
    title: info["meals"][0]["strMeal"],
    instructions: info["meals"][0]["strInstructions"],
    url: image,
    prep_time: (1..150).to_a.sample,
    difficulty: ["Easy", "Intermediate", "Advanced"].sample,
    user: User.all.sample,
    ingredients: ingredient
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
puts "Posts created successfully"
# TODO: Comments



# TODO: Workout instances
