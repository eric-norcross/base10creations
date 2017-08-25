class Manage::SectionTypesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_section_type, only: [:edit, :update, :destroy]

  # GET /section_types
  def index
    @section_types = SectionType.all
  end

  # GET /section_types/new
  def new
    @section_type = SectionType.new
  end

  # GET /section_types/1/edit
  def edit
  end

  # POST /section_types
  def create
    @section_type = SectionType.new(section_type_params)

    if @section_type.save
      redirect_to edit_manage_section_type_path(@section_type), notice: 'SectionType was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /section_types/1
  def update
    if @section_type.update(section_type_params)
      redirect_to edit_manage_section_type_path(@section_type), notice: 'SectionType was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /section_types/1
  def destroy
    @section_type.destroy
    redirect_to manage_section_types_url, notice: 'SectionType was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_section_type
      @section_type = SectionType.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def section_type_params
      params.require(:section_type)
        .permit(
          :name
        )
    end
end
