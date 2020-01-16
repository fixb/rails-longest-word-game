require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('a'..'z').to_a.sample }
  end

  def score
    @grid = params[:grid]
    @word = params[:word]

    if @word.chars.all? { |letter| @word.count(letter) <= @grid.count(letter) }
      response = open("https://wagon-dictionary.herokuapp.com/#{@word}")
        json = JSON.parse(response.read)
        if json["found"] == true
          @result = 1
          # @result = "Congratulation, #{@word.upcase} is a valid English word!"
        else
          @result = 2
    end
    else
      @result = 3
      # "Sorry but #{@word.upcase} can't be built out of #{@grid}..."
    end
  end
end
