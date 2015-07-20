require 'benchmark'
time = Benchmark.realtime do

all_words = File.read ('wordlist.txt')
all_words = all_words.split("\n")

h = Hash.new([])
max_number_of_anagrams = 0
max_length_of_word = 0
word_with_max_length = " "
key_with_max_anagrams = " "

all_words.each do |word|
  h[word.downcase.chars.sort.join] += [ word ]
end

open('out_version1.txt', 'w'){ |f|
  h.each do |key, anagrams|
    has = 0
    anagrams.uniq! { |elem| elem.downcase }

    if (anagrams.count > 1) then
      anagrams.map { |i| f.print i + " " }
      has = 1

      if(anagrams.count > max_number_of_anagrams) then
        max_number_of_anagrams = anagrams.count
        key_with_max_anagrams = key
      end

      if(anagrams[0].size > max_length_of_word) then
          max_length_of_word = anagrams[0].size
          word_with_max_length = anagrams[0]
      end
    end
    if (has == 1) then f.puts "\n"
    end
  end
}

puts "Longest set of anagrams:"
h[key_with_max_anagrams].each do |anagrams|
      print anagrams + "\n"
end

puts "Word with maximum nr of anagrams: " + h[key_with_max_anagrams][0] + " with " + max_number_of_anagrams.to_s +
 " anagrams. Key " + key_with_max_anagrams
puts "Word with maximum length that has anagrams: " + word_with_max_length + " having length " + max_length_of_word.to_s

end
puts time.to_s
