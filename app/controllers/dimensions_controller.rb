class DimensionsController < ApplicationController
  load_and_authorize_resource

  # Admin Routes
  def admin_index
    respond_to do |format|
      format.html
    end
  end


  # REST Routes
  # def index
  #   # @dimensions = Dimension.all

  #   respond_to do |format|
  #     format.html
  #   end
  # end

  # def show
  #   # @dimension = Dimension.find(params[:id])

  #   respond_to do |format|
  #     format.html
  #   end
  # end

  def new
    # @dimension = Dimension.new

    1.times do
      @dimension.images.build
    end

    respond_to do |format|
      format.html
    end
  end

  def edit
    # @dimension = Dimension.find(params[:id])
  end

  def create
    # @dimension = Dimension.new(params[:dimension])

    respond_to do |format|
      if @dimension.save
        format.html { redirect_to @dimension, notice: 'Dimension was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    # @dimension = Dimension.find(params[:id])

    respond_to do |format|
      if @dimension.update_attributes(params[:dimension])
        format.html { redirect_to dimensions_url, notice: 'Dimension was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    # @dimension = Dimension.find(params[:id])
    @dimension.destroy

    respond_to do |format|
      format.html { redirect_to dimensions_url }
      format.json { head :no_content }
    end
  end
end