class SectionsController < ApplicationController
  def index
    @sections = Section.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @section }
    end
  end

  # GET /section/1
  def show
    @side_nav_elements = Section.where(parent_id: 0)
    @page = Section.find(params[:id])

    render @page.skin.template

    # respond_to do |format|
    #   format.html # show.html.erb
    #   format.json { render json: @section }
    # end
  end

  # GET /section/new
  # GET /section/new.json
  def new
    @section = Section.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @section }
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
        format.html { redirect_to sections_path, notice: 'Section was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /section
  # POST /section.json
  def create
    @section = Section.new(params[:section])

    respond_to do |format|
      if @section.save
        format.html { redirect_to sections_path, notice: 'Section was successfully created.' }
        format.json { render json: @section, status: :created, location: @section }
      else
        format.html { render action: "new" }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /section/1
  # DELETE /section/1.json
  def destroy
    @section = Section.find(params[:id])
    @section.destroy

    redirect_to sections_path

    # respond_to do |format|
    #   format.html { redirect_to sections_path(index) }
    #   format.json { head :no_content }
    # end
  end
end
