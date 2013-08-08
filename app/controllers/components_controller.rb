class ComponentsController < ApplicationController
  def index
    @components = Component.all

    respond_to do |format|
      format.html # index.html.erb
      # format.json { render json: @components }
    end
  end

  def show
    # Get Component 
    @component = Component.find(params[:id])

    # Set up side nav
    @side_nav_elements = @component.siblings

    # Get Products & Compilations
    @component_ids = [params[:id]]
    unless @component.children.blank?
      @component_ids = @component.children.map{ |component| component.id }
    end

    @products = Component.products_and_compilations(@component_ids)

    render "layouts/templates/list"
  end

  def new
    @component = Component.new

    respond_to do |format|
      format.html # new.html.erb
      # format.json { render json: @component }
    end
  end

  def edit
    @component = Component.find(params[:id])
  end

  def create
    @component = Component.new(params[:component])

    respond_to do |format|
      if @component.save
        format.html { redirect_to components_url, notice: 'Component was successfully created.' }
        # format.json { render json: @component, status: :created, location: @component }
      else
        format.html { render action: "new" }
        # format.json { render json: @component.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @component = Component.find(params[:id])

    respond_to do |format|
      if @component.update_attributes(params[:component])
        format.html { redirect_to components_url, notice: 'Component was successfully updated.' }
        # format.json { head :no_content }
      else
        format.html { render action: "edit" }
        # format.json { render json: @component.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @component = Component.find(params[:id])
    @component.destroy

    respond_to do |format|
      format.html { redirect_to components_url }
      # format.json { head :no_content }
    end
  end
end
