# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

names = Array["John Doe", "James Smith", "Chris Heller", "Xebra Starfish", "Sean Walka"]
first_users = Array.new
names.each_with_index  do |name, index| 
	first_users << User.create({:user_name => name, :email => "user#{index}@gmail.com"})
end

clazzes = Array[
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

#clazzes = Array[{ :title => "Spanish", :sections => ["Nouns", "Adverbs", "Adjectives", "Grammar", "Phrases", "Culture"]}, { :title => "Micro Bio 101", :sections => ["Food", "Biotechnology"]}]
first_user = first_users[0]
clazzes.each_with_index do |each_clazz, index| 
	clazz = first_user.clazzs.create({:name => each_clazz[:title]})
	each_clazz[:sections].each do |section_name|
		clazz.sections.create({:title => section_name})
	end
end

