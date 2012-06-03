class PageNotesController < ApplicationController
	def index
		@rendered_json = ""
		respond_to do |format|
			format.html # index.html.erb
      		format.json { render json: rendered_json }
		end
	end

	#Ajax call that updates all notes on the page
	def update
		#Lets first fuck around with just changing the image index to 1 instead of 0
		page = Page.find(params[:id])
		@notes = params[:notes]
		@json_response = {"response" => "success"}
		@notes.each do |entry_item|
			note = Entry.find(entry_item["note_id"])
			attributes = entry_item[:attributes]
			note.image = attributes[:imageid]
			note.custom_css = "top: #{attributes[:top]}; left: #{attributes[:left]};"
			note.save!
			@json_response["response"] = "#{@json_response["response"]}#{note.id}"
			#We now have an entry, we can update it!!!
			#We also need to get the img id as that isn't working!!
			#we are sending back 
			#if we set up the json as if it was a note update then we can just push it in that way.
			#@json_response["response"] = "#{@json_response["response"]}#{note.id}"
			#product.update_attributes!(params[:product].reject { |k,v| v.blank? })
		end
		respond_to do |format|
	      #if @page.update_attributes(params[:page])
	        format.html { redirect_to @page, notice: 'Page was successfully updated.' }
	        format.json { render json: @json_response }
	        #format.js
	      #else
	      #  format.html { render action: "edit" }
	      #  format.json { render json: @page.errors, status: :unprocessable_entity }
	     # end
	    end
	end

end
