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

  def skus_by_finish
    @skus = Collection.skus_by_finish(params[:id], params[:finish_id])
    render "skus/_list", layout: false
  end

  # Admin Routes
  def admin_index
    respond_to do |format|
      format.html
    end
  end


  # REST Routes
  def index
    @side_nav_elements = @collections
    @products = @collections

    render "layouts/templates/list"
  end

  def show
    @side_nav_elements = Collection.all

    @products = Collection.products_and_compilations(params[:id])

    render "layouts/templates/list"
  end

  def new
    # @collection = Collection.new

    1.times do
      @collection.images.build
    end

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
        format.html { redirect_to admin_collections_path, notice: 'Collection was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    # @collection = Collection.find(params[:id])

    respond_to do |format|
      if @collection.update_attributes(params[:collection])
        format.html { redirect_to admin_collections_path, notice: 'Collection was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    # @collection = Collection.find(params[:id])
    @collection.destroy

    redirect_to admin_collections_path
  end
end
