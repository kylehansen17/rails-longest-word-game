require "json"
require "open-uri"

class GamesController < ApplicationController

  def new
    @alpha = ("A".."Z").to_a
    @letters = @alpha.sample(10)
  end

  def score
    @word = params[:word]
    @letters = params[:letters]

    if !included_in_grid?
      @result = "Sorry but #{@word} can't be built out of #{@letters}."
    elsif !english_word?(@word)
      @result = "Sorry but #{@word} does not seem to be an English word."
    else
      @result = "Congrats! #{@word} is a valid English word."
    end

  end

  private

  def included_in_grid?
    array = @word.split("")

    array.all? do |letter|
      answer_count = array.count(letter)
      grid_count = @letters.count(letter)
      answer_count <= grid_count
    end
  end

  def english_word?(word)
    url = "https://dictionary.lewagon.com/#{@word}"
    response = URI.parse(url).read
    data = JSON.parse(response)
    data["found"]
  end

end
