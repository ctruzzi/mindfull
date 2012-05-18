module ApplicationHelper

	def title 
		base_title = "Digital Notebook"
		if @title.nil?
			base_title
		else
			"#{@title} | #{base_title} "
		end
	end

	def clazz_title 

	end

	def logo_small
  		image_tag("logo_MindFull2.jpg", :alt => "digital notebook", :class => "round", :size => "118x79")
  	end

  	def popup_cancel 
  		"<input id='popup-cancel' name='popup-cancel' type='button' value='Cancel' onclick=\"$( '#popup' ).dialog( 'close' );\"/>"
  	end
end
