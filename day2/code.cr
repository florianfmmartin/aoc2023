data = File.read("./input.txt")

lines = data.split("\n")

MAX = {
  "red"   => 12,
  "green" => 13,
  "blue"  => 14,
}

class Game
  @id : Int32
  @subsets : Array(Hash(String, Int32))

  def id
    @id
  end

  def initialize(id, @subsets)
    @id = id.to_i
  end

  def max_hit_in_one_of_subset
    @subsets.reduce(true) { |acc, subset|
      acc &&
        subset.fetch("red", 0) <= MAX["red"] &&
        subset.fetch("green", 0) <= MAX["green"] &&
        subset.fetch("blue", 0) <= MAX["blue"]
    }
  end

  def get_color_value_list(color)
    @subsets.map { |subset|
      subset.fetch(color, 1)
    }
  end

  def get_fewer_power
    reds = get_color_value_list("red").max
    greens = get_color_value_list("green").max
    blues = get_color_value_list("blue").max

    reds * greens * blues
  end
end

games = lines.map { |line|
  game = line.split(/[;|:]/).map { |game|
    game.split(",").map { |part| part.strip }
  }
  Game.new(game[0][0].split(" ")[1], game[1..].map { |sub|
    subset = Hash(String, Int32).new
    sub.each { |t|
      num_col = t.split(" ")
      num = num_col[0].to_i
      col = num_col[1]
      subset[col] = num
    }
    subset
  })
}

solution1 = games
  .reject { |game| !game.max_hit_in_one_of_subset }
  .map { |game| game.id }
  .reduce(0) { |acc, i| acc + i }

solution2 = games
  .map { |game| game.get_fewer_power }
  .reduce(0) { |acc, i| acc + i }
