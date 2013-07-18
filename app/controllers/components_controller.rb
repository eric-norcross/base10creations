class ComponentsController < ApplicationController
  # def get_components
  #   # @components = Component.find(params[:id])
  #   @components = Component.where( :collection_id => params[:id]).order(:name) unless params[:id].blank?
  #   render "select", :locals => { :components => @components }
  # end

  def retrieve_components
    # if params[:id].present?
    #   @components = Collection.find(params[:id]).components
    # else
    #   @components = []
    # end

    # respond_to do |format|
    #   format.json
    # end


    @collections = Collection.find(params[:id])
    # # @components = Component.where( :collection_id => params[:id]).order(:name) unless params[:id].blank?
    @components = @collections.components
    # render "/components/_select", :locals => { :components => @components }

    render "components/_select", locals: { type: params[:type] }, layout: false

    # respond_to do |format|
    #   format.js
    # end
  end


  def index
    @components = Component.all

    respond_to do |format|
      format.html # index.html.erb
      # format.json { render json: @components }
    end
  end

  def show
    # @component = Component.find(params[:id])
    @side_nav_element = Component.find(params[:id])
    @product_components = ProductComponent.where(:component_id => params[:id])
    @product_ids = @product_components.map{ |product_component| product_component.product_id } #collection_id is "Bradley"
    # @products = Product.all(:conditions => { :id => @product_ids })
    @products = Product.where(:id => @product_ids)

    render "pages/templates/list"
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
