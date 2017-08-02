class Manage::SectionsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_section, only: [:show, :edit, :update, :destroy]

  # GET /sections
  def index
    @sections = Section.all
  end

  # GET /sections/1/edit
  def edit
  end

  # PATCH/PUT /sections/1
  def update
    if @section.update(section_params)
      redirect_to @section, notice: 'Section was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /sections/1
  def destroy
    @section.destroy
    redirect_to sections_url, notice: 'Section was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_section
      @section = Section.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def section_params
      params.require(:section)
        .permit(
          :name,
          :slug,

          # belongs_to
            :page_id,

          # has_one (Polymorphic)
            { :link_attributes => [
              :_destroy,
              :id,
              :target,
              :title,
              :uri,

              # polymorphic
                :linkable_id,
                :linkable_type
            ]},

          # has_many (Nested Attributes)
            { :figures_attributes => [
              :_destroy,
              :id,
              :alt,
              :image,
              :title,
              
              # polymorphic
                :figureable_id,
                :figureable_type
            ]},

            { :items_attributes => [
              :_destroy,
              :id,
              :name

              # belongs_to
                :section_id,

              # has_one (Polymorphic)
                { :link_attributes => [
                  :_destroy,
                  :id,
                  :target,
                  :title,
                  :uri,

                  # polymorphic
                    :linkable_id,
                    :linkable_type
                ]}
            ]}

        )
    end
end

