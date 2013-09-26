class CategoriesController < ApplicationController
  load_and_authorize_resource

  # Admin Routes
  def manage
    respond_to do |format|
      format.html
    end
  end


  # REST Routes
  def index
    @side_nav_elements = @categories
    @products = @categories

    render "layouts/templates/list"
  end

  def show
    # Get Component 
    # @category = Category.find(params[:id])

    # Set up side nav
    @side_nav_elements = Category.all

    # Get Products & Compilations
    @products = Component.products_and_compilations(@category.component_ids)

    render "layouts/templates/list"
  end

  def new
    # @category = Category.new

    1.times do
      @category.images.build
    end

    respond_to do |format|
      format.html
    end
  end

  def edit
    # @category = Category.find(params[:id])
  end

  def update
    # @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to manage_categories_path, notice: 'Category was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def create
    # @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        format.html { redirect_to manage_categories_path, notice: 'Category was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def destroy
    # @category = Category.find(params[:id])
    @category.destroy

    redirect_to manage_categories_path
  end
end
