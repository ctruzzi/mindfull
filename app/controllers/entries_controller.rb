class EntriesController < ApplicationController
  # GET /entries
  # GET /entries.json
  def index
    @entries = Entry.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @entries }
    end
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
    @entry = Entry.find(params[:id])
    hash = {:folder_index => 7, :entry_path => 1}
    @index_count = @entry.getImgCount(hash)

    hash.delete("entry_path")
    hash[:count] = 5;
    @image_array = @entry.getRndImgFromDir(hash)
    @image_name = @entry.image.split("/").last().split("_").last().split(".").first()
    img = @entry.image
    #@image_name = img[img.rindex('/')+1, img.length][img.rindex('_'), img.length]
    #.split(".")[0]
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @entry }
    end
  end

  # GET /entries/new
  # GET /entries/new.json
  def new
    @entry = Entry.new
    @entry.page_id = params[:current_page].nil? ? "missing" : params[:current_page];
    respond_to do |format|
      format.html # new.html.erb
      format.js
    end
  end

  # GET /entries/1/edit
  def edit
    @entry = Entry.find(params[:id])
  end

  # POST /entries
  # POST /entries.json
  def create
    page = Page.find(params[:entry][:page_id])
    params[:entry].delete("page_id")
    #Check if we can hit a helper method!
    #We need to check if theres a section directory with same (ie not a default)
    #IF 'default' randomly choose 7 pictures from all pictures of that specific directory
    #Else randomly choose 7 images from all pictures
    #Store these!!!
    @entry = page.entries.build(params[:entry])
    #Entry.new(params[:entry])

    #CHANGE 7 to section directory
    hash = {:folder_index => 7, :count => 5}
    image_array = @entry.getRndImgFromDir(hash)
    @entry.optional_images = image_array
    @entry.image = image_array[0]
    @entry.image_size = @entry.image.split("/").last().split("_").last().split(".").first()
    respond_to do |format|
      if @entry.save
        format.html { redirect_to @entry, notice: 'Entry was successfully created.' }
        #format.json { render json: @entry, status: :created, location: @entry }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /entries/1
  # PUT /entries/1.json
  def update
    @entry = Entry.find(params[:id])

    respond_to do |format|
      if @entry.update_attributes(params[:entry])
        format.html { redirect_to @entry, notice: 'Entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy

    respond_to do |format|
      format.html { redirect_to entries_url }
      #format.json { head :no_content }
      format.js { render :nothing => true }
    end
  end
end
