Dir.chdir("../assets/images/") #Sets to active directory
#puts "#{File.directory?("images")}"
#Counts number of images in thingy
directory = "entry_images"
count = Dir.glob(File.join("#{directory}", '**', '*')).select { |file| File.file?(file) }.count
puts count

file = Dir['entry_images/_39370365_german_cars_203*'][0]
puts "#{file}"

Dir.glob("**/*.txt") do |my_text_file|
  puts "working on: " + my_text_file + "... "
end