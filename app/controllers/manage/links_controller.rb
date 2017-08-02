class Manage::LinksController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_link, only: [:edit, :update, :destroy]

  # GET /links
  def index
    @links = Link.all
  end

  # GET /links/1/edit
  def edit
  end

  # PATCH/PUT /links/1
  def update
    if @link.update(link_params)
      redirect_to edit_manage_link_path(@link), notice: 'Link was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /links/1
  def destroy
    @link.destroy
    redirect_to manage_pages_url, notice: 'Link was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def link_params
      params.require(:link)
        .permit(
          :linkable_id,
          :linkable_type,
          :target,
          :title,
          :uri
        )
    end
end
