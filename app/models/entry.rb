# == Schema Information
#
# Table name: entries
#
#  id              :integer         not null, primary key
#  page_id         :integer
#  text            :string(255)
#  image           :string(255)
#  custom_css      :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  optional_images :string(255)
#  image_size      :string(255)
#


class Entry < ActiveRecord::Base
	serialize :optional_images
	serialize :custom_css
	attr_accessible :text, :image, :custom_css, :optional_images, :image_size

	#has_many :image, :class_name => 'Image', :foreign_key => 'optional_images'
	belongs_to :page, :class_name => "Page", :foreign_key => "page_id"
	DEFAULT_DIRECTORY = "entry_images"

	#Gets us image count of the subdirectory
	def getImgCount(hash)
		setImgDir()
		inner_path = DEFAULT_DIRECTORY
		inner_path += "/#{hash[:folder_index]}" unless hash[:folder_index].nil?
		inner_path += "/#{hash[:entry_path]}" unless hash[:entry_path].nil?
		#Count all real files that aren't txt
		Dir.glob(File.join("#{inner_path}", '**', '*')).select { |file| File.file?(file) && !file.end_with?(".txt") }.count
	end

	def getFolderCount(directory)
		inner_path = directory.nil? ? "" : "/#{directory}"
		Dir.entries("#{DEFAULT_DIRECTORY}#{inner_path}").size - 2
	end

	#If we get say 7, then we get count of folders, choose one and randomly choose one 
	#Hash
	# :count => number of random images to return
	# :directory => actual directory
	def getRndImgFromDir(hash) 
		setImgDir()
		folder_count = getFolderCount(hash[:folder_index]) #Get folder count of directory
		output_array = []
		i = 0;
		while i < hash[:count]  do
		   hash[:entry_path] = (rand(folder_count * folder_count) % folder_count) + 1
		   file_path = Dir["#{DEFAULT_DIRECTORY}/#{hash[:folder_index]}/#{hash[:entry_path]}/#{getRndImgFromSubDir(hash)}*"]
		   output_array << (file_path.nil? ? "" : file_path[0])
		   i +=1;
		end
		output_array
		
		#get count of subfolders
		#Get random value
		#Call Subdir to get random image
	end

	def getRndImgFromSubDir(hash)
		count = getImgCount(hash)
		rand(count * count) % count + 1
	end

	private

	def setImgDir
		directory = Dir.pwd;
		if(!directory.end_with?("app/assets/images"))
			#if(directory.end_with?("/7"))
			#	Dir.chdir("../")
			#end
			Dir.chdir("app/assets/images/")
		end
	end

end

