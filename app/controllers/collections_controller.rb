class CollectionsController < ApplicationController
  load_and_authorize_resource
  # skip_authorize_resource :only => [:finishes, :products]

  # Ajax Routes
  def finishes
    @finishes = Collection.finishes(params[:id])
    render "finishes/_select", locals: { type: params[:type] }, layout: false
  end

  def products
    @products = Collection.products(params[:id])
    render "products/_select", layout: false
  end


  # REST Routes
  def index
    # @collections = Collection.all

    respond_to do |format|
      format.html # index.html.erb
      # format.json { render json: @collections }
    end
  end

  def show
    @side_nav_elements = Collection.all

    @products = Collection.products_and_compilations(params[:id])

    render "layouts/templates/list"
  end

  def new
    # @collection = Collection.new

    respond_to do |format|
      format.html
    end
  end

  def edit
    # @collection = Collection.find(params[:id])
  end

  def create
    # @collection = Collection.new(params[:collection])

    respond_to do |format|
      if @collection.save
        format.html { redirect_to collections_url, notice: 'Collection was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    # @collection = Collection.find(params[:id])

    respond_to do |format|
      if @collection.update_attributes(params[:collection])
        format.html { redirect_to collections_url, notice: 'Collection was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    # @collection = Collection.find(params[:id])
    @collection.destroy

    redirect_to collections_url
  end
end
