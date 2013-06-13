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

    render "components/_select", layout: false

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

  # def show
  #   @component = Component.find(params[:id])

  #   respond_to do |format|
  #     format.html # show.html.erb
  #     # format.json { render json: @component }
  #   end
  # end

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
