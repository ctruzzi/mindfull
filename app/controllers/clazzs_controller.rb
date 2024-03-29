class ClazzsController < ApplicationController
  # GET /clazzs
  # GET /clazzs.json
  def index
    @clazzs = Clazz.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @clazzs }
    end
  end

  # GET /clazzs/1
  # GET /clazzs/1.json
  def show
    @clazz = Clazz.find(params[:id])

    if(params[:current].nil?)
      @current_page = @clazz.sections.first.pages.first
    else
      @current_page = Section.find(params[:current]).pages.first
      @color = @current_page.section.color[:color]
    end
    @current_page_id = @current_page.id
    @color = @current_page.section.color
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @clazz }
    end
  end

  # GET /clazzs/new
  # GET /clazzs/new.json
  def new
    @clazz = Clazz.new
    respond_to do |format|
      format.html # new.html.erb
      #format.json { render json: @clazz }
      format.js
    end
  end

  # GET /clazzs/1/edit
  def edit
    @clazz = Clazz.find(params[:id])
  end

  # POST /clazzs
  # POST /clazzs.json
  def create
    @clazz = current_user.clazzs.build(params[:clazz])

    respond_to do |format|
      if @clazz.save
        @clazz_amt = current_user.clazzs.size - 1
        format.html { redirect_to(@clazz, :notice => 'class created.') }  
        format.js
      else
        @clazz_amt = "error"
        format.html { render :action => "new" }  
        #format.json { render json: @clazz.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /clazzs/1
  # PUT /clazzs/1.json
  def update
    @clazz = Clazz.find(params[:id])

    respond_to do |format|
      if @clazz.update_attributes(params[:clazz])
        format.html { redirect_to @clazz, notice: 'Clazz was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @clazz.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clazzs/1
  # DELETE /clazzs/1.json
  def destroy
    @clazz = Clazz.find(params[:id])
    @clazz.destroy

    respond_to do |format|
      format.html { redirect_to clazzs_url }
      #format.json { head :no_content }
      format.js { render :nothing => true }
    end
  end
end
