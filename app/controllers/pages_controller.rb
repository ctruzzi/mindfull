#Pages.where("userId = ? AND sectionId = ?", #, #)

class PagesController < ApplicationController
  # GET /pages
  # GET /pages.json
  def index
    @pages = Page.all
    #@pages = Page.where("userId = ? AND sectionId = ?", 1, 1)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pages }
    end
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
    @page = Page.find(params[:id])
    respond_to do |format|
      @color = @page.section.color
      format.html # show.html.erb
      #format.json { render json: @page }
      format.js
    end
  end

  # GET /pages/new
  # GET /pages/new.json
  def new
    @page = Page.new
    @page.section_id = params[:section]
    respond_to do |format|
      format.html # new.html.erb
     #format.json { render json: @page }
      format.js
    end
  end

  # GET /pages/1/edit
  def edit
    @page = Page.find(params[:id])
  end

  # POST /pages
  # POST /pages.json
  def create
    #params[:page][:section_id] = Section.find(params[:section_id])
    if(params[:page].nil?) 
      #Auto Create, not taking params other then section
      autoName = "autoName#{Section.find(params[:section]).pages.size + 1}"
      params[:page] = {:section_id => params[:section], :title => autoName}
      @page = current_user.pages.build(params[:page])
    else 
      params[:page][:section_id] = params[:section_id]
      @page = current_user.pages.build(params[:page])
    end

    #hidden value for this on e  <%= f.hidden_field :clazz_id, {:value => @section.clazz_id}  %>
    respond_to do |format|
      if @page.save
        @pageSize = @page.section.pages.size
        format.html { redirect_to @page, notice: 'Page was successfully created.' }
        #format.json { render json: @page, status: :created, location: @page }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pages/1
  # PUT /pages/1.json
  def update
    @page = Page.find(params[:id])
    @page.section_id = params[:section_id] unless params[:section_id].nil? 
    @page.title = params[:title] unless params[:title].nil? 

    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { redirect_to @page, notice: 'Page was successfully updated.' }
        #ormat.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to pages_url }
      format.json { head :no_content }
    end
  end
end
