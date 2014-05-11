class FiguresController < ApplicationController
  authorize_resource
  before_filter :load_figurable

  # Admin Routes
  def manage
    @figures = @figurable

    respond_to do |format|
      format.html
    end
  end

  def show
    @figure = @figurable.figures.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def new
    @figure = @figurable.figures.new

    1.times do
      @figure.images.build
    end

    respond_to do |format|
      format.html
    end
  end

  def edit
    @figure = @figurable.figures
  end

  def create
    @figure = @figurable.figures.new(params[:id])

    respond_to do |format|
      if @figure.save
        format.html { redirect_to @figurable, notice: 'Figure was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @figure = @figurable.figures.find(params[:id])

    respond_to do |format|
      if @figure.update_attributes(params[:figure])
        format.html { redirect_to @figurable, notice: 'Figure was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @figure = @figurable.figures.find(params[:id])
    @figure.destroy

    respond_to do |format|
      format.html { redirect_to @figurable }
    end
  end

  private

  def load_figurable
    resource, id = request.path.split('/')[1, 2]
    # @figurable = resource.singularize.classify.constantize.find(id)
    
    if is_number(id)
      @figurable = resource.singularize.classify.constantize.find(id)
    else
      @figurable = resource.singularize.classify.constantize.all
    end
  end

  def is_number(id)
    true if Float(self) rescue false
  end
end