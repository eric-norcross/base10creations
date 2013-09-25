class FinishesController < ApplicationController
  load_and_authorize_resource

  # Admin Routes
  def admin_index
    respond_to do |format|
      format.html
    end
  end


  # REST Routes
  def index
    @side_nav_elements = @finishes
    @products = @finishes

    render "layouts/templates/list"
  end

  def show
    @side_nav_elements = Finish.all
    
    @products = Finish.skus(params[:id]) + Finish.compilations(params[:id])

    render "layouts/templates/list"
  end

  def new
    # @finish = Finish.new

    # @finish.image.build

    1.times do
      @finish.images.build
    end

    respond_to do |format|
      format.html
    end
  end

  def edit
    # @finish = Finish.find(params[:id])
  end

  def create
    # @finish = Finish.new(params[:finish])

    respond_to do |format|
      if @finish.save
        format.html { redirect_to admin_finishes_path, notice: 'Finish was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    # @finish = Finish.find(params[:id])

    respond_to do |format|
      if @finish.update_attributes(params[:finish])
        format.html { redirect_to admin_finishes_path, notice: 'Finish was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    # @finish = Finish.find(params[:id])
    @finish.destroy

    redirect_to admin_finishes_path
  end
end