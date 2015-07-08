words = File.read ('wordlist.txt')

require 'iconv' unless String.method_defined?(:encode)
if String.method_defined?(:encode)
  words.encode!('UTF-16', 'UTF-8', :invalid => :replace, :replace => '')
  words.encode!('UTF-8', 'UTF-16')
else
  ic = Iconv.new('UTF-8', 'UTF-8//IGNORE')
  words = ic.iconv(file_contents)
end

words2 = words.split("\n")

h = Hash.new([])
words2.each.with_index do |el, i|
  h[el.downcase.chars.sort.join] += [i]
end

open('out.txt', 'a'){ |f|
  h.each do |key, indexes|
    indexes.map do
      |i| f.print words2[i] + " "
    end
    f.puts "\n"
  end
}
