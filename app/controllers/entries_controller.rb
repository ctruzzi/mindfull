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

    @entry = page.entries.build(params[:entry])
    #Entry.new(params[:entry])
    count = 5
    #Outer level is the clazz, inner level is the section
    outer_level = page.section.clazz.id;
    inner_level = page.section.clazz.sections.index(page.section) + 1
    #inner_level = page.section.id
    possible_images = Image.find(:all, :conditions => ["first_level = ? and second_level = ?", outer_level, inner_level])
    p "outer #{outer_level}   inner #{inner_level} img# #{possible_images.size}"
    image_choices = []
    if(possible_images.size == 0) 
      #Find Random images (do by id)
      total_possible = Image.count
      for i in 0..4
        begin
          input = rand(total_possible) + 1
        end while image_choices.include? input
        image_choices << input
      end 
    elsif possible_images.size < count
      #Iterate through possible_images and put their ID's into the list
      possible_images.each do |image|
        image_choices << possible_images.id
      end
    else
      #Just choose 5 random from specific folder
      p "CHOOOOOOSE 5 pictures"
      temp = []
      for i in 0..4
        begin
          input = rand(possible_images.size) + 1
        end while temp.include? input
        temp << input
        image_choices << possible_images[input]
      end 
      p "#{image_choices}"
    end


    #Send those into 
    #CHANGE 7 to section directory
    #hash = {:folder_index => 7, :count => 5}

    #image_array = @entry.getRndImgFromDir(hash)
    @entry.optional_images = image_choices
    @entry.image = 0 #This is the index of the imag ein the image_array
    #@entry.image_size = @entry.image.split("/").last().split("_").last().split(".").first()
    respond_to do |format|
      if @entry.save
       # @current_image = Image.find(image_choices[0])
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
