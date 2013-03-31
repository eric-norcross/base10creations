class SkinsController < ApplicationController
  def index
    @skins = Skin.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @skin }
    end
  end

  # GET /skin/1
  def show
    @skin = Skin.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @skin }
    end
  end

  # GET /skin/new
  # GET /skin/new.json
  def new
    @skin = Skin.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @skin }
    end
  end

  # GET /skins/1/edit
  def edit
    @skin = Skin.find(params[:id])
  end

  # PUT /skins/1
  # PUT /skins/1.json
  def update
    @skin = Skin.find(params[:id])

    respond_to do |format|
      if @skin.update_attributes(params[:skin])
        format.html { redirect_to skin_path, notice: 'Skin was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @skin.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /skin
  # POST /skin.json
  def create
    @skin = Skin.new(params[:skin])

    respond_to do |format|
      if @skin.save
        format.html { redirect_to @skin, notice: 'Skin was successfully created.' }
        format.json { render json: @skin, status: :created, location: @skin }
      else
        format.html { render action: "new" }
        format.json { render json: @skin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /skin/1
  # DELETE /skin/1.json
  def destroy
    @skin = Skin.find(params[:id])
    @skin.destroy

    render "skins/index"

    # respond_to do |format|
    #   format.html { redirect_to skin_path(index) }
    #   format.json { head :no_content }
    # end
  end
end