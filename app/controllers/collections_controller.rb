class CollectionsController < ApplicationController
    def index
    @collections = Collection.all

    respond_to do |format|
      format.html # index.html.erb
      # format.json { render json: @collections }
    end
  end

  def show
    @collections = Collection.find(params[:id])

    render "/collections/templates/collection"
    # respond_to do |format|
    #   format.html # show.html.erb
    #   # format.json { render json: @collection }
    # end
  end

  def new
    @collection = Collection.new

    respond_to do |format|
      format.html # new.html.erb
      # format.json { render json: @collection }
    end
  end

  def edit
    @collection = Collection.find(params[:id])
  end

  def create
    @collection = Collection.new(params[:collection])

    respond_to do |format|
      if @collection.save
        format.html { redirect_to collections_url, notice: 'Collection was successfully created.' }
        # format.json { render json: @collection, status: :created, location: @collection }
      else
        format.html { render action: "new" }
        # format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @collection = Collection.find(params[:id])

    respond_to do |format|
      if @collection.update_attributes(params[:collection])
        format.html { redirect_to collections_url, notice: 'Collection was successfully updated.' }
        # format.json { head :no_content }
      else
        format.html { render action: "edit" }
        # format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @collection = Collection.find(params[:id])
    @collection.destroy

    respond_to do |format|
      format.html { redirect_to collections_url }
      # format.json { head :no_content }
    end
  end
end
