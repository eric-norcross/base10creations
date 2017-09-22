class Manage::SectionsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_section, only: [:show, :edit, :update, :destroy]

  # GET /sections
  def index
    @sections = Section.includes(
                  :link,
                  :page,
                  :section_type,
                  :parent,
                  :figures, 
                  :items,
                  children: [
                    :link,
                    :figures, 
                    :items
                  ]
                ).all
  end

  # GET /sections/new
  def new
    @section = Section.new
  end

  # GET /sections/1/edit
  def edit
  end

  # POST /sections
  def create
    @section = Section.new(section_params)

    if @section.save
      redirect_to edit_manage_section_path(@section), notice: 'Section was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /sections/1
  def update
    if @section.update(section_params)
      redirect_to edit_manage_section_path(@section), notice: 'Section was successfully updated.'
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
      @section  = Section.includes(
                    :link,
                    :figures, 
                    :items,
                    children: [
                      :link,
                      :figures, 
                      :items
                    ]
                  ).friendly.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def section_params
      params.require(:section)
        .permit(
          :id,
          :name,
          :content,
          :slug,
          :shown,

          # belongs_to
            :page_id,
            :parent_id,
            :section_type_id,

          # has_many (Polymorphic)
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
            { :items_attributes => [
              :_destroy,
              :id,
              :name,

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
            ]},

            { :children_attributes => [
              :_destroy,
              :id,
              :name,
              :content,
              :slug,
              :shown,

              # belongs_to
                :parent_id,
                :section_type_id,

              # has_many (Polymorphic)
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

              # has_many
                { :items_attributes => [
                  :_destroy,
                  :id,
                  :name,

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
            ]}
        )
    end
end

