# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
class SeedHelper

	CLAZZES = Array[
		{ :title => "Spanish", 
			:sections => ["Nouns", "Adverbs", "Adjectives", "Grammar", "Phrases", "Culture"]
		}, { :title => "Micro Bio 101", 
			:sections => ["Food", "Biotechnology"]
		}, {
			:title => "Socioecology", 
			:sections => ["Social Systems", "Adaptive Significance", "Ecology"]
		}, {
			:title => "Anthropology", 
			:sections => ["Early Human Society"]
		}, {
			:title => "Eviornmental Science",
			:sections => ["Global weather", "Ecological Niches"]
		}, { 
			:title => "Honors 212", 
			:sections => ["The Idea", "Central Humanities", "Experiential Learning", "Honors Portfolio", "Methods of Research", "Natural Sciences"]
		}, {
			:title => "Art History 102", 
			:sections => ["1900-1920", "Modern Art", "Dada"]
		}, {
			:title => "Genetics 483", 
			:sections => ["Human Disease", "Cultural Behavior", "Natural Habitat", "Determinism", "Cultural Selection", "Gene Flow"]
		}, {
			:title => "Philosophy",
			:sections => ["Foundations", "Nature of reality", "Nature of morality"]
		}
	]

	COLORS = [{:color => "#EE5F33", :h_color => "#943820"}, 
		{:color => "#F6AD4E", :h_color => "#B37A1E"}, 
		{:color => "#80C152", :h_color => "#59873A"}, 
		{:color => "#3AA7B6", :h_color => "#287580"}, 
		{:color => "#EB3577", :h_color => "#96224C"}]
	NAMES = Array["John Doe", "James Smith", "Chris Heller", "Xebra Starfish", "Sean Walka"]

	def setUpClasses

		first_users = Array.new
		NAMES.each_with_index  do |name, index| 
			first_users << User.create({:user_name => name, :email => "user#{index}@gmail.com"})
		end
		first_user = first_users[0]
		CLAZZES.each_with_index do |each_clazz, index| 
			clazz = first_user.clazzs.create({:name => each_clazz[:title]})
			each_clazz[:sections].each_with_index do |section_name, inner_index|
				the_section = clazz.sections.create({:title => section_name, :color => COLORS[inner_index % COLORS.size]})
				#For some reason the section isn't creating the default Page
				first_user.pages.create!({:title => "Default", :section_id => the_section.id})
			end
		end
	end

	DEFAULT_DIRECTORY = "/app/assets/images/entry_images"
	def setUpImageDB
		directory = Dir.pwd
		#p directory
		folders = getFolders("")
		folders.each do |outer_folder| 
			#p outer_folder
			inner_folders = getFolders("#{outer_folder}")
			inner_folders.each do |inner_folder|
				images = getImages("/#{outer_folder}/#{inner_folder}")
				images.each do |image|
					p "#{outer_folder}    #{inner_folder}    #{image}"
					size = image[/_[0-9]+x[0-9]+./].gsub(/[_.]/, "").split("x");
					Image.create!({:first_level => outer_folder, :second_level => inner_folder, :image_url => image, :x => size[0], :y => size[1]})
					#p "first_level[#{outer_folder}] second_level[#{inner_folder}] image_ur[#{image}] x[#{size[0]}] y[#{size[1]}]"
				end
			end
		end
	end

	private

	def getFolders(specific_path)
		path_end = specific_path.empty? ? "" : "/#{specific_path}"
		directory = "#{Dir.pwd}#{DEFAULT_DIRECTORY}#{path_end}"
		Dir.entries(directory).select do
			|folder| folder!= "." && folder!= ".."
		end
	end

	def getImages(path) 
		directory = "#{Dir.pwd}#{DEFAULT_DIRECTORY}#{path}/"
		Dir.glob(File.join("#{directory}", '**', '*')).select { |file| File.file?(file) && !file.end_with?(".txt") }.each{ |s| s.replace(s.sub(directory, "")) }
	end


end
seed_helper = SeedHelper.new
seed_helper.setUpClasses
seed_helper.setUpImageDB




