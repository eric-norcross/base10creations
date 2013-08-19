class SectionsController < ApplicationController
  load_and_authorize_resource

  def index
    # @sections = Section.all

    respond_to do |format|
      format.html
    end
  end

  def show
    @side_nav_elements = Section.where(parent_id: 0)
    @page = Section.find(params[:id])

    render @page.skin.template
  end

  def new
    # @section = Section.new

    respond_to do |format|
      format.html
    end
  end

  def edit
    # @section = Section.find(params[:id])
  end

  def update
    # @section = Section.find(params[:id])

    respond_to do |format|
      if @section.update_attributes(params[:section])
        format.html { redirect_to sections_path, notice: 'Section was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def create
    # @section = Section.new(params[:section])

    respond_to do |format|
      if @section.save
        format.html { redirect_to sections_path, notice: 'Section was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def destroy
    # @section = Section.find(params[:id])
    @section.destroy

    redirect_to sections_path
  end
end
