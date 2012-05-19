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
  		link_to image_tag("logo_MindFull2.jpg", :alt => "digital notebook", :class => "round", :size => "118x79", :style => "float: left"), "root_path"
  	end

  	def popup_cancel 
  		"<input id='popup-cancel' name='popup-cancel' type='button' value='Cancel' onclick=\"$( '#popup' ).dialog( 'close' );\"/>"
  	end
end
