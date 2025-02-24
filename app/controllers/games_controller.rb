require "open-uri"

class GamesController < ApplicationController

  def new
    @letters = []
    10.times do
      @letters << ("A".."Z").to_a.sample
    end
  end


  def score
    @answer = params[:word]
    @grid = params[:grid]

# -------------- mot est anglais ----------------------

    url = "https://dictionary.lewagon.com/#{@answer}"
    word_serialized = URI.parse(url).read
    word = JSON.parse(word_serialized)
    is_english = word['found']

# -------------- mot est dans la grille ----------------

    in_the_grid = @answer.chars.all? {|letter| @answer.count(letter) <= @grid.count(letter)}

# ------------------------------------------------------

    if in_the_grid
      if is_english
        @result = "Congrats #{@answer} is english and in the grid!"
      else
        @result = "#{@answer} is in the grid but not english"
      end
    else
      @result = "Sorry but #{@answer} is not using letters in the grid."
    end
  end
end
