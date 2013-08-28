class SkusController < ApplicationController
  load_and_authorize_resource

  # Admin Routes
  def admin_index
    respond_to do |format|
      format.html
    end
  end


  # REST Routes
  # def index
  #   # @skus = Sku.all

  #   respond_to do |format|
  #     format.html
  #   end
  # end

  def show
    # @sku = Sku.find(params[:id])
    @product = Product.find(@sku.product.id)
    @products_and_compilations = Product.where(collection_id: @product.collection_id) + Compilation.where(collection_id: @product.collection_id)
    @categories = @product.categories
    
    @related = []
    @products_and_compilations.each do |item|
      if item.categories.to_set.superset?(@categories.to_set)
        @related.push(item)
      end
    end

    render @product.skin.template
  end

  def new
    # @sku = Sku.new

    3.times { @sku.images.build }

    respond_to do |format|
      format.html
    end
  end

  def edit
    # @sku = Sku.find(params[:id])
  end

  def create
    # @sku = Sku.new(params[:sku])

    respond_to do |format|
      if @sku.save
        format.html { redirect_to admin_skus_path, notice: 'Sku was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    # @sku = Sku.find(params[:id])

    respond_to do |format|
      if @sku.update_attributes(params[:sku])
        format.html { redirect_to admin_skus_path, notice: 'Sku was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    # @sku = Sku.find(params[:id])
    @sku.destroy

    redirect_to admin_skus_path
  end
end
