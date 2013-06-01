class ImagesController < ApplicationController
  def index
    @imageable = Finish.find(params[:finish_id])
    @images    = @imageable.images
  end

  def new
    @image = @imageable.images.new
  end

  def create
    @image = @imageable.images.new(params[:image])

    if @image.save
      redirect_to [@imageable, :images], notice: "Image Created"
    else 
      render :new
    end
  end

private
  
  def load_imageable
    resources, id = request.path.split('/')[1,2]
    @imageable    = resources.singularize.classify.constantize.find(id)
  end

  # def load_imageable
  #   klass       = [Finish, Dimension].detect { |c| params["#{c.name.underscore}_id"]}
  #   @imageable  = klass.find(params["#{klass.name.underscore}_id"])
  # end
end
