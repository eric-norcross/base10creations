class CompilationsController < ApplicationController
  def index
    @compilations = Compilation.all

    STDOUT << "TEST"

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @compilations }
    end
  end

  # GET /compilations/1
  def show
    @compilation = Compilation.find(params[:id])
    @related = Product.where(collection_id: @compilation.collection_id) + Compilation.where(collection_id: @compilation.collection_id)

    render "#{@compilation.skin.template}"
  end

  # GET /compilations/new
  # GET /compilations/new.json
  def new
    @compilation = Compilation.new

    3.times do
      @compilation.images.build
    end

    # 1.times do
    #   dimensions = @compilation.dimensions.build
    #   dimensions.image.build
    # end

    # 1.times do
    #   skus = @compilation.skus.build
    #   1.times { skus.images.build }
    # end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @compilation }
    end
  end

  # GET /compilations/1/edit
  def edit
    @compilation = Compilation.find(params[:id])
  end

  # POST /compilations
  # POST /compilations.json
  def create
    @compilation = Compilation.new(params[:compilation])

    respond_to do |format|
      if @compilation.save
        format.html { redirect_to compilations_url, notice: 'Compilation was successfully created.' }
        format.json { render json: compilations_url, status: :created, location: @compilation }
      else
        format.html { render action: "new" }
        format.json { render json: @compilation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /compilations/1
  # PUT /compilations/1.json
  def update
    @compilation = Compilation.find(params[:id])

    respond_to do |format|
      if @compilation.update_attributes(params[:compilation])
        format.html { redirect_to compilations_url, notice: 'Compilation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @compilation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /compilations/1
  # DELETE /compilations/1.json
  def destroy
    @compilation = Compilation.find(params[:id])
    @compilation.destroy

    respond_to do |format|
      format.html { redirect_to compilations_url }
      format.json { head :no_content }
    end
  end
end