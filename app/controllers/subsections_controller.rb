class SubsectionsController < ApplicationController
  def index
    @subsections = Subsection.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @subsection }
    end
  end

  # GET /subsection/1
  def show
    @page = Subsection.find(params[:id])

    render "#{@page.skin.template}"
  end

  # GET /subsection/new
  # GET /subsection/new.json
  def new
    @subsection = Subsection.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @subsection }
    end
  end

  # GET /subsections/1/edit
  def edit
    @subsection = Subsection.find(params[:id])
  end

  # PUT /subsections/1
  # PUT /subsections/1.json
  def update
    @subsection = Subsection.find(params[:id])

    respond_to do |format|
      if @subsection.update_attributes(params[:subsection])
        format.html { redirect_to subsections_path, notice: 'Subsection was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @subsection.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /subsection
  # POST /subsection.json
  def create
    @subsection = Subsection.new(params[:subsection])

    respond_to do |format|
      if @subsection.save
        format.html { redirect_to subsections_path, notice: 'Subsection was successfully created.' }
        format.json { render json: @subsection, status: :created, location: @subsection }
      else
        format.html { render action: "new" }
        format.json { render json: @subsection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subsection/1
  # DELETE /subsection/1.json
  def destroy
    @subsection = Subsection.find(params[:id])
    @subsection.destroy

    render "subsections/index"

    # respond_to do |format|
    #   format.html { redirect_to subsections_path(index) }
    #   format.json { head :no_content }
    # end
  end
end
