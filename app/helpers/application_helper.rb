module ApplicationHelper

	def title 
		base_title = "Digital Notebook"
		if @title.nil?
			base_title
		else
			"#{@title} | #{base_title} "
		end
	end

	def logo_small
  		link_to image_tag("logo_MindFull2.jpg", :alt => "digital notebook", :class => "round", :size => "118x79", :style => "float: left"), root_path
  	end
		
  	def logo
		link_to image_tag("logo_clear_200x184.png", :alt => "digital notebook", :size => "200x184", :style => "float: left"), root_path
  	end

  	def popup_cancel(id)
  		"<input id='popup-cancel' name='popup-cancel' type='button' value='Cancel' onclick=\"$( '##{id}' ).dialog( 'close' );\"/>"
  	end
end
