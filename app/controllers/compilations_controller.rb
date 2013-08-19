class CompilationsController < ApplicationController
  load_and_authorize_resource

  def index
    # @compilations = Compilation.all

    respond_to do |format|
      format.html
    end
  end

  def show
    # @compilation = Compilation.find(params[:id])
    @products_and_compilations = Product.where(collection_id: @compilation.collection_id) + Compilation.where(collection_id: @compilation.collection_id)
    @categories = @compilation.categories
    
    @related = []
    @products_and_compilations.each do |item|
      if item.categories.to_set.superset?(@categories.to_set)
        @related.push(item)
      end
    end
    
    render @compilation.skin.template
  end

  def new
    # @compilation = Compilation.new

    3.times do
      @compilation.images.build
    end

    respond_to do |format|
      format.html
    end
  end

  def edit
    # @compilation = Compilation.find(params[:id])
  end

  def create
    # @compilation = Compilation.new(params[:compilation])

    respond_to do |format|
      if @compilation.save
        format.html { redirect_to compilations_url, notice: 'Compilation was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    # @compilation = Compilation.find(params[:id])

    respond_to do |format|
      if @compilation.update_attributes(params[:compilation])
        format.html { redirect_to compilations_url, notice: 'Compilation was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    # @compilation = Compilation.find(params[:id])
    @compilation.destroy

    respond_to do |format|
      format.html { redirect_to compilations_url }
    end
  end
end