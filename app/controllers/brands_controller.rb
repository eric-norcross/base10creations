class BrandsController < ApplicationController
  # before_filter :find_products, :only => :show
  load_and_authorize_resource

  # Admin Routes
  def admin_index
    respond_to do |format|
      format.html
    end
  end


  # REST Routes
  def index
    @side_nav_elements = @brands
    @products = @brands

    render "layouts/templates/list"
  end

  def show
    @side_nav_elements = Brand.all

    @products = Brand.products_and_compilations(params[:id])

    render "layouts/templates/list"
  end

  def new
    # @brand = Brand.new

    1.times do
      @brand.images.build
    end

    # 1.times do
    #   figures = @brand.figures.build
    #   figures.images.build
    # end

    respond_to do |format|
      format.html
    end
  end

  def edit
    # @brand = Brand.find(params[:id])
  end

  def create
    # @brand = Brand.new(params[:brand])

    respond_to do |format|
      if @brand.save
        format.html { redirect_to admin_brands_path, notice: 'Brand was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    # @brand = Brand.find(params[:id])

    respond_to do |format|
      if @brand.update_attributes(params[:brand])
        format.html { redirect_to admin_brands_path, notice: 'Brand was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    # @brand = Brand.find(params[:id])
    @brand.destroy

    redirect_to admin_brands_path
  end

  private

  # def find_products
  #   # Get Products & Compilations
  #   @products = Brand.products_and_compilations(params[:id])
  # end
end
