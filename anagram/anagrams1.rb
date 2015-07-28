require 'benchmark'
time=Benchmark.realtime do
  word_with_most_anagrams=""
  max_number_of_anagrams=0
  longest_word_with_anagrams=""
  words=Hash.new([])
  puts "Opening entry file and doing things for you..."
  File.open("wordlist.txt","r") do |f|
    f.readlines.each do |line|
      l=line.chomp
      lalala = l.downcase.chars.sort.join
      clone=words[lalala].map{|word| word.downcase}
      words[lalala]+=[l] unless clone.include?(l.downcase)
      if max_number_of_anagrams < words[lalala].count
        max_number_of_anagrams=words[lalala].count
        word_with_most_anagrams=lalala
      end
      longest_word_with_anagrams=lalala if longest_word_with_anagrams.length < l.length &&  words[lalala].count > 1

    end
  end
  puts "Finished creating Hash"
  open("exit.txt" , "w") do |exitfile|
    words.each do |k,v|
      if words[k].count>1
        v.each {|val| exitfile.print(val+" ") }
        exitfile.puts
      end
    end
    exitfile.print "\nThe first longest word with anagrams is #{words[longest_word_with_anagrams][0]} and \
it has #{longest_word_with_anagrams.length} letters"
    exitfile.print "\nThe first word with the most anagrams is #{words[word_with_most_anagrams][0]} with \
#{max_number_of_anagrams} anagrams and the anagrams are #{words[word_with_most_anagrams]} "
  end
  puts "Finished writing exitfile. Over."

end
puts time
