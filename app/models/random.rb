=begin
Dir.chdir("../assets/images/") #Sets to active directory

#puts "#{File.directory?("images")}"
#Counts number of images in thingy
directory = "entry_images"
count = Dir.glob(File.join("#{directory}", '**', '*')).select { |file| File.file?(file) }.count
puts count

file = Dir['entry_images/_39370365_german_cars_203*'][0]
puts "#{file}"

Dir.glob("**/*.txt") do |my_text_file|
  #puts "working on: " + my_text_file + "... "
end

=end

some_var = "entry_images/7/6/5_425x283.jpeg"

puts some_var.rindex('.')
puts some_var[some_var.rindex('/'), some_var.rindex('.')]
t = "0123456789"
puts t[t.rindex('2'), t.rindex('3')]

ve = "234x321"
p ve.split("x")