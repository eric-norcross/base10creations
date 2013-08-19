class BrandsController < ApplicationController
  # before_filter :find_products, :only => :show
  load_and_authorize_resource

  def index
    # @brands = Brand.all

    respond_to do |format|
      format.html
    end
  end

  def show
    @side_nav_elements = Brand.all

    @products = Brand.products_and_compilations(params[:id])

    render "layouts/templates/list"
  end

  def new
    # @brand = Brand.new

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
        format.html { redirect_to brands_url, notice: 'Brand was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    # @brand = Brand.find(params[:id])

    respond_to do |format|
      if @brand.update_attributes(params[:brand])
        format.html { redirect_to brands_url, notice: 'Brand was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    # @brand = Brand.find(params[:id])
    @brand.destroy

    respond_to do |format|
      format.html { redirect_to brands_url }
    end
  end

  private

  # def find_products
  #   # Get Products & Compilations
  #   @products = Brand.products_and_compilations(params[:id])
  # end
end
