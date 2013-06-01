class ImagesController < ApplicationController
  before_filter :load_imageable
  
  def index
    @images = @imageable.images
  end

  def new
    @image = @imageable.images.new
  end

  def create
    @image = @imageable.images.new(params[:image])
    if @image.save
      redirect_to @imageable, notice: "Image created."
    else
      render :new
    end
  end

private

  def load_imageable
    resource, id = request.path.split('/')[1, 2]
    @imageable = resource.singularize.classify.constantize.find(id)
  end

  # alternative option:
  # def load_imageable
  #   klass = [Article, Photo, Event].detect { |c| params["#{c.name.underscore}_id"] }
  #   @imageable = klass.find(params["#{klass.name.underscore}_id"])
  # end
end

