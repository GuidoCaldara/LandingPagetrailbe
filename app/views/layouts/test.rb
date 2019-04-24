require "open-uri"
require "json"

def generate_grid(grid_size)
 grid = []
 grid_size.times do
   grid << ("A"..."Z").to_a.sample(1)
 end
 return grid.flatten
end

def check_api(json, result, attempt, end_time)
 result1 = {}
 if json["found"] == true
   result1[:score] = attempt.size * 10
   result1[:score] -= end_time
   result1[:message] = "Well done!"
 else
   result1[:score] = 0
   result1[:message] = "Not an English word!"
 end
 result1[:time] = result[:time]
 result1
 #return Hash[result.map { |k, v| [k.to_sym, v] }]
end


def run_game(attempt, grid, start_time, end_time)
 # TODO: runs the game and return detailed hash of result
 result = { "time" => end_time - start_time, "score" => 0, "message" => "" }
 url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
 url_serialized = open(url).read
 json = JSON.parse(url_serialized)
 # grid is an array of characters

 result = check_api(json, result, attempt, (end_time - start_time))

 if attempt.chars.all? { |letter| grid.count(letter) >= attempt.chars.count(letter) }
   result[:message] = "Well done!"
 else
   result[:score] = 0
   result[:message] = "Not in the grid!"
 end
 result
 return Hash[result.map { |k, v| [k.to_sym, v] }]

end
