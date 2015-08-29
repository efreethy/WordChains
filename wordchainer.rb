require 'set'
require 'byebug'

class WordChainer
  attr_reader :dictionary
  attr_accessor :current_words, :all_seen_words

  def initialize(dictionary_file_name, current_words = [])
    @dictionary = Set.new(File.readlines(dictionary_file_name).map(&:chomp))
    @all_seen_words = {}
    @current_words = current_words
  end

  def adjacent_words(word)
    # adjacent_words = []
    # right_length = @dictionary.select { |entry| entry.length == word.length }
    # right_length.select do |entry|
    # is_adjacent?(word, entry)

    candidates = build_adjacent(word)
    candidates.select { |entry| dictionary.include?(entry) }
  end


  def build_adjacent(word)
    words = []
    (0..3).each do |i|
       ("a".."z").to_a.each do |letter|
         word_dup = word.dup
         word_dup[i] = letter
         words.push(word_dup)
       end
     end

     words
  end

  def explore_current_words(current_word, new_current_words)
    adjacent_words(current_word).each do |adjacent_word|
      unless all_seen_words.keys.include?(adjacent_word)
        new_current_words << adjacent_word
        all_seen_words[adjacent_word] = current_word
      end
    end
  end

  def run(source, target)
    self.current_words << source
    self.all_seen_words[source] = nil

    until current_words.empty? || all_seen_words.keys.include?(target)
      new_current_words = []
      current_words.each do |current_word|
        explore_current_words(current_word, new_current_words)
      end
      # puts new_current_words
      self.current_words = new_current_words
    end

    build_path(target)
  end

  def build_path(target)
    # self.all_seen_words.keys.select { |key| all_seen_words[key] == source }
    path = [target]

    parent = all_seen_words[target]
    until parent.nil?
      path << parent
      parent = all_seen_words[parent]
    end
    
    path.reverse
  end
end
