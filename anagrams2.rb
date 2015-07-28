require 'benchmark'
class Anagrams
  attr_reader :words, :longest_word_with_anagrams, :word_with_most_anagrams, :max_number_of_anagrams

  def initialize file_name
    puts "Creating new object..."
    @file_name=File.open(file_name,"r")
    @words=Hash.new([])
    @longest_word_with_anagrams=""
    @word_with_most_anagrams=""
    @max_number_of_anagrams=0
  end

  def create_value line
    value=line.chomp
    value
  end

  def create_key line
    l=line.chomp
    key=l.downcase.chars.sort.join
    key
  end

  def create_hash
    puts "Creating Hash..."
    @file_name.readlines.each do |line|
      key=create_key(line)
      value=create_value(line)
      @words[key] += [value] unless duplicate(@words[key], value)
      words_key_size=words[key].size
      calculate_longest_word_with_anagrams(words_key_size, value)
      calculate_word_with_most_anagrams(words_key_size, value)
    end
  end

  def duplicate words, value
    clone=words.map {|word| word.downcase}
    if clone.include?(value.downcase)
      return true
    else
      return false
    end
  end

  def calculate_longest_word_with_anagrams number_of_anagrams, value
    @longest_word_with_anagrams=value if number_of_anagrams>1 && @longest_word_with_anagrams.length<value.length
  end

  def calculate_word_with_most_anagrams number_of_anagrams, value
    if @max_number_of_anagrams<number_of_anagrams
      @word_with_most_anagrams=value
      @max_number_of_anagrams=number_of_anagrams
    end
  end

  def output file_name
    puts "Writing exit file..."
    File.open(file_name, "w") do |exitfile|
      @words.each do |k,v|
        if @words[k].count>1
          v.each {|val| exitfile.print(val+" ") }
          exitfile.puts
        end
      end
      exitfile.puts "#{@longest_word_with_anagrams} is the longest word with anagrams"
      exitfile.puts "#{@word_with_most_anagrams} is the word with #{@max_number_of_anagrams} anagrams, being the word with most anagrams"
    end
  end

end
time=Benchmark.realtime do

  anagram=Anagrams.new("wordlist.txt")
  anagram.create_hash
  anagram.output("exit2.txt")
  puts "Done"
end
puts time
