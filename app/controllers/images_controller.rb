class ImagesController < ApplicationController
  before_filter :load_imageable
  load_and_authorize_resource

  # def index
  #   @images = @imageable.images
  # end

  # def show
  # end

  def new
    @image = @imageable.images.new
  end

  # def edit
  # end

  def create
    @image = @imageable.images.new(params[:image])

    if @image.save
      format.html { redirect_to @imageable, notice: "Image created." }
    else 
      format.html { render :new }
    end
  end

  def update
    @image = @imageable.images.find(params[:id])

    respond_to do |format|
      if @image.update_attributes(params[:image])
        format.html { redirect_to @imageable, notice: 'Image was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @image = @imageable.images.find(params[:id])
    @image.destroy
  end


  private

  def load_imageable
    resource, id = request.path.split('/')[1, 2]
    @imageable = resource.singularize.classify.constantize.find(id)
  end
end
