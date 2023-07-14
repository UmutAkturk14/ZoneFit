require "open-uri"
Comment.where(commentable_type: "Recipes").delete_all
Post.where.not(thumbnail: nil).or(Post.where.not(url: nil))
puts "Deleting Recipes..."
Recipe.delete_all

# TODO: Recipes API data
url = "https://www.themealdb.com/api/json/v1/1/random.php"

300.times do
  var = URI.open(url).read
  info = JSON.parse(var)
  n = 1
  # puts info["meals"][0]["strIngredient"+"#{n}"]
  ingredient = ""
  while info["meals"][0]["strIngredient"+"#{n}"].present? && info["meals"][0]["strIngredient"+"#{n}"] != ""
    ingredient += (info["meals"][0]["strMeasure"+"#{n}"] + " " + info["meals"][0]["strIngredient"+"#{n}"]) + ","
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
