class WordGuesserGame
  attr_accessor :word, :guesses, :wrong_guesses

  MAX_WRONG_GUESSES = 7

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(letter)
    raise ArgumentError, "must guess a single character" if letter.nil? || letter.empty?
    raise ArgumentError, "must guess a letter" unless letter =~ /^[a-zA-Z]$/

    letter = letter.downcase

    return false if @guesses.include?(letter) || @wrong_guesses.include?(letter)

    if @word.downcase.include?(letter)
      @guesses += letter
    else
      @wrong_guesses += letter
    end

    true
  end

  def check_win_or_lose
    if @wrong_guesses.length >= MAX_WRONG_GUESSES
      :lose
    elsif @word.downcase.chars.all? { |c| @guesses.include?(c) }
      :win
    else
      :play
    end
  end

  def word_with_guesses
    @word.downcase.chars.map { |c| @guesses.include?(c) ? c : '-' }.join
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('https://randomword.saasbook.info/RandomWord.txt')
    Net::HTTP.get(uri)
  end
end