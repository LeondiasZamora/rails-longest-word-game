require "open-uri"

class GamesController < ActionController::Base
  def new
    @letters =[]
    10.times do
      @letters.push(('a'..'z').to_a.sample.upcase)
    end

  end

  def score
    user_input_split =  params[:word].split("")
    if count_letters && english_word
      @message="well done!"
    elsif !english_word
      @message ="#{params[:word]} is not an english word sorry"
    else
      @message="the letters are not included"
    end
  end

  def english_word
    response = URI.open("https://dictionary.lewagon.com/#{params[:word]}")
    json = JSON.parse(response.read)
    json['found']
  end

  def count_letters
    letters_hash = params[:letters].split(",").tally
    word_hash = params[:word].upcase.gsub(" ", "").split("").tally
    word_hash.keys.all? { |word_letter| letters_hash.keys.include?(word_letter)} && word_hash.keys.all? { |word_letter| letters_hash[word_letter] >= word_hash[word_letter] }
  end





  # def contains_letters
  #   numbers_array = []
  #   pp @letters
  #   raise
  #   params[:word].chars.each do |word_letter|
  #     if @letters.include? word_letter
  #       numbers_array.push(1)
  #     else
  #       numbers_array.push(0)
  #     end
  #     return numbers_array.inlcude?(0)
  #   end
  # end
end

{
 "a" => 7
}
