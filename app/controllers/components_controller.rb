class ComponentsController < ApplicationController
  require 'family'
  
  load_and_authorize_resource
  
  # Admin Routes
  def manage
    respond_to do |format|
      format.html
    end
  end


  # REST Routes
  def index
    @side_nav_elements = @components
    @products = @components

    render "layouts/templates/list"
  end

  def show
    # Get Component 
    # @component = Component.find(params[:id])

    @components = Component.all

    # Set up side nav
    # @side_nav_elements = @component.siblings
    # @side_nav_elements = Family.siblings(@components, @component)
    
    @side_nav_elements = @components #.select{ |component| component.parent_id == 0 }
    
    @component_ids = [params[:id]] + Family.children(@components, @component).map{ |component| component.id }

    @products = Component.products_and_compilations(@component_ids).sort_by! {|p| p.collection.title}

    @active = @component


    render "layouts/templates/list"
  end

  def new
    # @component = Component.new

    1.times do
      @component.images.build
    end

    respond_to do |format|
      format.html
    end
  end

  def edit
    # @component = Component.find(params[:id])
  end

  def create
    # @component = Component.new(params[:component])

    respond_to do |format|
      if @component.save
        format.html { redirect_to manage_components_path, notice: 'Component was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    # @component = Component.find(params[:id])

    respond_to do |format|
      if @component.update_attributes(params[:component])
        format.html { redirect_to manage_components_path, notice: 'Component was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    # @component = Component.find(params[:id])
    @component.destroy

    respond_to do |format|
      format.html { redirect_to manage_components_path }
    end
  end
end
