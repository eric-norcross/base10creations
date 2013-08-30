class StylesController < ApplicationController
  load_and_authorize_resource

  # Admin Routes
  def admin_index
    respond_to do |format|
      format.html
    end
  end


  # REST Routes
  def index
    @side_nav_elements = @styles
    @products = @styles

    render "layouts/templates/list"
  end

  def show
    @side_nav_elements = Style.all
    @products = Style.products_and_compilations(params[:id])

    render "layouts/templates/list"
  end

  def new
    # @style = Style.new

    @collections = Collection.all

    @slice_size = 3
    if @collections.length < 3
      @slice_size = 1
    end

    1.times { @style.images.build }

    respond_to do |format|
      format.html
    end
  end

  def edit
    # @style = Style.find(params[:id])
  end

  def create
    # @style = Style.new(params[:style])

    respond_to do |format|
      if @style.save
        format.html { redirect_to admin_styles_path, notice: 'Style was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    # @style = Style.find(params[:id])

    respond_to do |format|
      if @style.update_attributes(params[:style])
        format.html { redirect_to admin_styles_path, notice: 'Style was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    # @style = Style.find(params[:id])
    @style.destroy

    redirect_to admin_styles_path
  end
end
