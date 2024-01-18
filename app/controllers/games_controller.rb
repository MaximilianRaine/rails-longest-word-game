class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  before_action :set_original_grid, only: [:new, :score]

  def score
    user_word = params[:word].upcase

    unless word_can_be_built?(user_word, @original_grid)
      @result = "The word can't be built out of the original grid."
      return
    end

    if valid_english_word?(user_word)
      @result = "Congratulations! The word is valid according to the grid and is an English word."
    else
      @result = "The word is valid according to the grid but is not a valid English word."
    end
  end

  private

  def set_original_grid
    @original_grid = Array.new(10) { ('A'..'Z').to_a.sample }
    @original_grid.shuffle!
  end

  def word_can_be_built?(word, grid)
    return false if word.nil? || word.empty?

    word.chars.all? { |letter| grid.include?(letter) }
  end

  # def valid_english_word?(word)
  #   response = HTTParty.get("https://wagon-dictionary.herokuapp.com/#{word}")
  #   JSON.parse(response.body)['valid']
  # end
end
