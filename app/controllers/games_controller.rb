require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def english_word?
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{params[:word]}")
    json = JSON.parse(response.read)
    return json['found']
  end

  def includes?
    @letters = params[:letters]
    params[:word].chars.all? { |letter| params[:word].count(letter) <= @letters.count(letter) }
  end

  def score
    if includes?
      if english_word?
        @sentence = 'well done'
      else
        @sentence = 'not an english word'
      end
    else
      @sentence = 'not in the grid'
    end
  end
end
