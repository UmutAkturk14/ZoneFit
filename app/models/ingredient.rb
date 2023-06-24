require 'uri'
require 'net/http'

class Ingredient < ApplicationRecord
  belongs_to :recipe

  def self.search_nutrition(query)
    url = URI("https://nutrition-by-api-ninjas.p.rapidapi.com/v1/nutrition?query=#{URI.encode_www_form_component(query)}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request['X-RapidAPI-Key'] = '48b6192f7amshb5e2a948637df63p1d867ajsne93026296e26'
    request['X-RapidAPI-Host'] = 'nutrition-by-api-ninjas.p.rapidapi.com'

    response = http.request(request)
    json = JSON.parse(response.body)

    if json['status'] == 'ok'
      # Extract the relevant nutrient data from the response
      nutrient_data = json['data']['nutrition']['nutrients']

      # Create a new ingredient record with the nutrient data
      new_ingredient = Ingredient.create(
        name: json['data']['name'],
        protein: nutrient_data['protein'],
        carbohydrates: nutrient_data['carbohydrates'],
        fat: nutrient_data['fat'],
        calories: nutrient_data['calories']
      )

      return new_ingredient
    else
      # API request failed, handle the error scenario
      return nil
    end
  end
end
