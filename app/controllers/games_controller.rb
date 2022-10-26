require "json"
require "open-uri"

class GamesController < ApplicationController

  def new
    abc_array = ('a'..'z').to_a
    @display_letters = abc_array.sample(abc_array.size * 10).take(9)
  end

  def score

    @grid = params[:grid].upcase
    @word = params[:word]
    url = "https://wagon-dictionary.herokuapp.com/#{@word.to_s}"
    response = JSON.parse(URI.open(url).read)
    if response["found"]
      if valid?(@word, @grid)
        @output = 2
      else
        @output = 1
      end
    else
      @output = 0
    end
  end

  private

  def valid?(word, grid)
    grid_array = grid.downcase.split('')
    word.strip.downcase.split('').each do |letter|
      return false if grid_array.reject! { |elem| elem == letter }.nil?
    end
    true
  end
end
