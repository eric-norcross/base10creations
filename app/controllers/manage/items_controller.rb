class Manage::ItemsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_item, only: [:edit, :update, :destroy]

  # GET /items
  def index
    @items = Item.all
  end

  # GET /items/1/edit
  def edit
  end

  # PATCH/PUT /items/1
  def update
    if @item.update(item_params)
      redirect_to edit_manage_item_path(@item), notice: 'Item was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /items/1
  def destroy
    @item.destroy
    redirect_to manage_items_url, notice: 'Item was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.includes(
                :link
              ).find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def item_params
      params.require(:item)
        .permit(
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
            ]},
        )
    end
end
