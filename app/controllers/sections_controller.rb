class SectionsController < ApplicationController
  # GET /sections
  # GET /sections.json
  def index
    @sections = Section.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sections }
    end
  end

  # GET /sections/1
  # GET /sections/1.json
  def show
    @section = Section.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @section }
    end
  end

  # GET /sections/new
  # GET /sections/new.json
  def new
    @section = Section.new
    @section.clazz_id = params[:clazz]
    respond_to do |format|
      format.html # new.html.erb
      format.js
    end
  end

  # POST /sections
  # POST /sections.json
  def create
    #@section = current_user.clazzs.build(params[:section])
    clazz = Clazz.find(params[:clazz_id])
    @section = clazz.sections.build(params[:section])

    respond_to do |format|
      if @section.save
        #add a default page in the section
        @page = current_user.pages.create!({:title => "Default", :section_id => @section.id})
        format.html { redirect_to @section, notice: 'Section was successfully created.' }
        #format.json { render json: @section, status: :created, location: @section } 
        format.js
      else
        #This currently works because we return the entire page.
        format.html { render action: "new" }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /sections/1/edit
  def edit
    @section = Section.find(params[:id])
  end

  # PUT /sections/1
  # PUT /sections/1.json
  def update
    @section = Section.find(params[:id])

    respond_to do |format|
      if @section.update_attributes(params[:section])
        format.html { redirect_to @section, notice: 'Section was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sections/1
  # DELETE /sections/1.json
  def destroy
    @section = Section.find(params[:id])
    @section.destroy

    respond_to do |format|
      format.html { redirect_to sections_url }
      #format.json { head :no_content }
      format.js { render :nothing => true }
    end
  end
end
