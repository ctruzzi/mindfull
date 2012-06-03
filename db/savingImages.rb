

class ImageMethods
	DEFAULT_DIRECTORY = "/../app/assets/images/entry_images"
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

image_m = ImageMethods.new
directory = Dir.pwd
#Get to the images folder and then iterate through first_level
folders = image_m.getFolders("")
folders.each do |outer_folder| 
	p outer_folder
	inner_folders = image_m.getFolders("#{outer_folder}")
	inner_folders.each do |inner_folder|
		p inner_folder
		p image_m.getImages("/#{outer_folder}/#{inner_folder}")
	end
end