class ImagesController < ApplicationController
  authorize_resource
  before_filter :load_imageable

  def set_active
    Image.find(params[:id]).update_attributes(params[:image])
    render :nothing => true, :status => 200, :content_type => 'text/html'
  end

  def set_nil_active_to_true
    Image.where(active: nil).update_all(active: true)
    flash[:notice] = 'All records have been updated.'
    redirect_to :back
  end

  def new
    @image = @imageable.images.new
  end

  def create
    @image = @imageable.images.new(params[:image])

    respond_to do |format|
      if @image.save
        format.html { redirect_to @imageable, notice: "Image created." }
      else 
        format.html { render :new }
      end
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
