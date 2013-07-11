class ProductsController < ApplicationController
  def retrieve_products
    # if params[:id].present?
    #   @components = Collection.find(params[:id]).components
    # else
    #   @components = []
    # end

    # respond_to do |format|
    #   format.json
    # end


    @products = Product.where(:collection_id => params[:id])
    # # @components = Component.where( :collection_id => params[:id]).order(:name) unless params[:id].blank?
    # @components = @collections.components
    # render "/components/_select", :locals => { :components => @components }

    render "products/_select", layout: false

    # respond_to do |format|
    #   format.js
    # end
  end

  def index
    @products = Product.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end

  # GET /products/1
  def show
    @product = Product.find(params[:id])

    render "#{@product.skin.template}"
  end

  # GET /products/new
  # GET /products/new.json
  def new
    @product = Product.new

    1.times do
      @product.images.build
    end

    1.times do
      dimensions = @product.dimensions.build
      dimensions.image.build
    end

    1.times do
      skus = @product.skus.build
      1.times { skus.images.build }
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save
        format.html { redirect_to products_url, notice: 'Product was successfully created.' }
        format.json { render json: products_url, status: :created, location: @product }
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to products_url, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end
end