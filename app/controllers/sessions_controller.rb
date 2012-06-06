class SessionsController < ApplicationController
    CLAZZES = Array[
    { :title => "Spanish", 
      :sections => ["Nouns", "Adverbs", "Adjectives", "Grammar", "Phrases", "Culture"]
    }, { :title => "Micro Bio 101", 
      :sections => ["Bacteriology", "Immunology", "Parasitology", "Virology"]
    }, {
      :title => "Socioecology", 
      :sections => ["Social Systems", "Social Mobility", "Stratification"]
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
      :sections => ["5th-16th Century", "20th Century", "Logic"]
    }
  ]

  COLORS = [{:color => "#EE5F33", :h_color => "#943820"}, 
    {:color => "#F6AD4E", :h_color => "#B37A1E"}, 
    {:color => "#80C152", :h_color => "#59873A"}, 
    {:color => "#3AA7B6", :h_color => "#287580"}, 
    {:color => "#EB3577", :h_color => "#96224C"}]

    NOTES_SECTION_1 = [
    ["left: 38px; top: 17px;", "left: 451px; top: 294px;", "left: 32px; top: 203px;", " left: 490px; top: 11px; ", "left: 855px; top: 10px;", "left: 40px; top: 10px; ", "left: 906px; top: 240px;", "left: 488px; top: 105px;"],
    ["left: 34px; top: 14px;", "left: 347px; top: 413px;", "843px; top: 181px;", "left: 441px; top: 40px;"],
    ["left: 81px; top: 24px;", "left: 927px; top: 35px; ", "left: 530px; top: 258px;", "left: 53px; top: 334px;", "left: 479px; top: 34px;"],
    ["left: 32px; top: 10px;", "left: 387px; top: 31px;"],
    ["left: 32px; top: 10px;", "left: 125px; top: 276px; ", "left: 612px; top: 279px;", "left: 800px; top: 10px;"],
    ["left: 34px; top: 19px;", "left: 915px; top: 344px;", "left: 440px; top: 196px;"]
  ]

  NOTES_SECTION_2 = [
    ["left: 832px; top: 395px;", "left: 49px; top: 419px;", "left: 32px; top: 10px;"],
    ["left: 371px; top: 10px;", "left: 32px; top: 302px;", "left: 815px; top: 483px;", "left: 815px; top: 10px;"],
    ["", "left: 915px; top: 498px;"],
    ["", "left: 343px; top: 419px;", "left: 386px; top: 10px;"]
  ]
  NOTES_SECTION_3 = [
    ["", "left: 422px; top: 59px;", "left: 888px; top: 59px;"],
    ["left: 530px; top: 10px;", "left: 240px; top: 219px;", "left: 815px; top: 167px;"],
    ["left: 32px; top: 402px;", "left: 815px; top: 444px;", "left: 498px; top: 18px;"]
  ]
  NOTES_SECTION_4 = [
    ["left: 32px; top: 10px;", "left: 32px; top: 429px;", "left: 543px; top: 10px;", "left: 877px; top: 302px;"]
  ]
  NOTES_SECTION_5 = [
    ["", "left: 395px; top: 255px;", "left: 383px; top: 10px;", "left: 34px; top: 347px;", "left: 882px; top: 10px;"],
    ["", "left: 655px; top: 10px;", "left: 410px; top: 381px;", "left: 815px; top: 351px;"]
  ]
  NOTES_SECTION_6 = []
  NOTES_SECTION_7 = [
    ["", "left: 32px; top: 181px;", "left: 913px; top: 10px;", "left: 835px; top: 405px;", "left: 541px; top: 20px;", "left: 32px; top: 573px;", "left: 64px; top: 67px;", "left: 879px; top: 10px;"],
    ["", "left: 319px; top: 255px;", "left: 290px; top: 466px;", "left: 32px; top: 444px;", "left: 393px; top: 48px;", "left: 32px; top: 10px;", "left: 827px; top: 108px;"],
    ["", "left: 875px; top: 40px;", "left: 378px; top: 280px;", "left: 32px; top: 268px;", "left: 444px; top: 10px;"]
  ]
  NOTES_SECTION_8 = []
  NOTES_SECTION_9 = [
    ["left: 826px; top: 58px;", "left: 261px; top: 10px;", "left: 564px; top: 385px;", "left: 32px; top: 454px;"],
    ["left: 113px; top: 27px;", "left: 376px; top: 10px;", "left: 43px; top: 290px;", "left: 534px; top: 255px;"],
    ["", "left: 463px; top: 16px;", "left: 693px; top: 536px;"]
  ]

  def new
	@title = "Sign in"
  	render :layout => 'signin_layout'
  end
  
  def create
    p "[#{params[:session][:user_name]}]"
    if (params[:session][:user_name].empty?)
        flash.now[:error] = "Invalid email"
        @title = "Sign in"
        redirect_to '/signin'
    else 
    user = User.find_by_user_name(params[:session][:user_name])

      if user.nil?
        params[:session][:email] = "temp@temp.com"
        user = User.new(params[:session])
        user.save

        CLAZZES.each_with_index do |each_clazz, index| 
          clazz = user.clazzs.create({:name => each_clazz[:title]})
          each_clazz[:sections].each_with_index do |section_name, inner_index|

            the_section = clazz.sections.create({:title => section_name, :color => COLORS[inner_index % COLORS.size]})
            #For some reason the section isn't creating the default Page
            user.pages.create!({:title => "Default", :section_id => the_section.id})
          end
        end
        #add the categories for the customer
      else
        Clazz.delete_all
        Page.delete_all
        Entry.delete_all
        CLAZZES.each_with_index do |each_clazz, index| 
          clazz = user.clazzs.create({:name => each_clazz[:title]})
          each_clazz[:sections].each_with_index do |section_name, inner_index|

            the_section = clazz.sections.create({:title => section_name, :color => COLORS[inner_index % COLORS.size]})
            #For some reason the section isn't creating the default Page
            user.pages.create!({:title => "Default", :section_id => the_section.id})
          end
        end
        user = User.authenticate(user,"")
        setUpImageDB(user)

      end

      #Check if the user exists, if it doesn't then create it
    	if user.nil?
    		#User is nil menaing we didn't find that email address
    		flash.now[:error] = "Invalid email"
    		@title = "Sign in"
    		render 'new'	
    	else
    		#Sign user in and redirect to the users home page
    		sign_in user
  		  redirect_to user
    	end
    end
  end

  def destroy
  	sign_out
  	redirect_to root_path
  end


  DEFAULT_DIRECTORY = "/app/assets/images/entry_images"
  def setUpImageDB(user)

    cssNoteArray = [NOTES_SECTION_1, NOTES_SECTION_2, NOTES_SECTION_3, NOTES_SECTION_4, NOTES_SECTION_5, NOTES_SECTION_6, NOTES_SECTION_7, NOTES_SECTION_8, NOTES_SECTION_9]
    directory = Dir.pwd
    #p directory
    clazzs = user.clazzs
    
    folders = getFolders("")
    folders.each do |outer_folder| 
      #p outer_folder
      
      #Section of first user.
      clazz = clazzs[Integer(outer_folder) - 1]
      sections = clazz.sections 
      
      inner_folders = getFolders("#{outer_folder}")
      inner_folders.each do |inner_folder|
        section = sections[Integer(inner_folder) - 1]
        page = section.pages.first

        third_levels = getFolders("/#{outer_folder}/#{inner_folder}")
        total_pages = third_levels.size / 6
        if(total_pages >= 1) 
          User.first.pages.create!({:title => "Second Page", :section_id => section.id})
        end
        third_levels.each do |third_level|
          if(Integer(third_level) == 6)
            #Switch to second page
            page = section.pages.second
          end
          image_choices = []
          #images = getImages("/#{outer_folder}/#{inner_folder}/#{third_level}")

          #p "/#{outer_folder}/#{inner_folder}/#{third_level}"
          #images.each do |image|
          #  #p "#{outer_folder}    #{inner_folder}     #{third_level}     #{image}"
          #  size = image[/_[0-9]+x[0-9]+./].gsub(/[_.]/, "").split("x");
          #  img = Image.create!({:first_level => outer_folder, :second_level => inner_folder, :image_url => "#{third_level}/#{image}", :x => size[0], :y => size[1]})
          #  image_choices << img.id
          #end
          directory_path = "#{Dir.pwd}#{DEFAULT_DIRECTORY}/#{outer_folder}/#{inner_folder}/#{third_level}/"

          if(File.exist?("#{directory_path}/Text.txt"))
            lines = File.readlines("#{directory_path}/Text.txt")                                 #{image_info[:img]}"
          else
            lines = File.readlines("#{directory_path}/text.txt")    
          end
          img_ch = Image.find(:all, :conditions => ["first_level = ? and second_level = ? and image_url LIKE ?", outer_folder, inner_folder, "#{third_level}_%"], :select => 'id')
          img_ch.each do |image_single|
            image_choices << image_single.id
          end
          page.entries.create!({:text => lines.join, :optional_images => image_choices, :image => 0, :custom_css => cssNoteArray[Integer(outer_folder) - 1][Integer(inner_folder) - 1][Integer(third_level) - 1]})
          #p "#{outer_folder}    #{inner_folder}     #{third_level}     text.txt"
        end
      end
    end
  end

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
