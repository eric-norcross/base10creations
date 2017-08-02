class Manage::PagesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_page, only: [:show, :edit, :update, :destroy]

  # GET /pages
  def index
    @pages = Page.all
  end

  # GET /pages/new
  def new
    @page = Page.new
  end

  # GET /pages/1/edit
  def edit
  end

  # POST /pages
  def create
    @page = Page.new(page_params)

    if @page.save
      redirect_to edit_manage_page_path(@page), notice: 'Page was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /pages/1
  def update
    if @page.update(page_params)
      redirect_to edit_manage_page_path(@page), notice: 'Page was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /pages/1
  def destroy
    @page.destroy
    redirect_to manage_pages_url, notice: 'Page was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def page_params
      params.require(:page).permit(:name)
    end

private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      slug = params[:id]

      @page = Page.includes(
              :figures,
              sections: [
                :figures,
                :items
              ],
            ).friendly.find(slug)
    end

    # Only allow a trusted parameter "white list" through.
    def page_params
      params.require(:page)
        .permit(
          :name,
          :slug,

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

            { :sections_attributes => [
              :_destroy,
              :id,
              :header,
              :content,
              :link,
              :link_text,
              :sub_header,

              # belongs_to
                :page_id,

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

