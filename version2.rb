require 'benchmark'
time = Benchmark.realtime do

  h = Hash.new([])
  max_number_of_anagrams = 1
  max_length_of_word = 0
  word_with_max_length = " "
  key_with_max_anagrams = " "

  File.open('wordlist.txt', 'r') do |f|
    f.readlines.each do |word|
      word.chomp!
      key = word.downcase.chars.sort.join
      h[key] += [ word ]
      h[key].uniq! { |elem| elem.downcase }

      if h[key].count > 1 then
        if h[key][0].size > max_length_of_word then
          max_length_of_word = h[key][0].size
          word_with_max_length = h[key][0]
        end
        if h[key].count >= max_number_of_anagrams then
          max_number_of_anagrams = h[key].count
          key_with_max_anagrams = key
        end
      end
    end
  end

open('out_version2.txt', 'w'){ |f|
  h.each do |key, anagrams|
    has_anagrams = 0
    if anagrams.count > 1 then
      anagrams.map { |anagram| f.print anagram + " " }
      has_anagrams = 1
    end
    if has_anagrams == 1 then f.puts "\n"
    end
  end
}

puts "Longest set of anagrams:"
h[key_with_max_anagrams].each do |anagram|
      print anagram + "\n"
end

puts "Word with maximum nr of anagrams: " + h[key_with_max_anagrams][0] + " with " + max_number_of_anagrams.to_s +
 " anagrams."
puts "Word with maximum length that has anagrams: " + word_with_max_length + " having length " + max_length_of_word.to_s

end

puts time.to_s
