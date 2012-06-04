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

  def new
	@title = "Sign in"
  	render :layout => 'signin_layout'
  end
  
  def create
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
      user = User.authenticate(user,"")
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

  def destroy
  	sign_out
  	redirect_to root_path
  end
  
end
