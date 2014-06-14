class SkinsController < ApplicationController
  authorize_resource

  def manage
    @skins = Skin.all

    respond_to do |format|
      format.html 
      format.json { render json: @skins }
    end
  end

  def show
    @skin = Skin.find(params[:id])

    redirect_to skins_path
  end

  def new
    @skin = Skin.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @skin }
    end
  end

  def edit
    @skin = Skin.find(params[:id])
  end

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

  def update
    @skin = Skin.find(params[:id])

    respond_to do |format|
      if @skin.update_attributes(params[:skin])
        format.html { redirect_to @skin, notice: 'Skin was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @skin.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @skin = Skin.find(params[:id])
    @skin.destroy

    respond_to do |format|
      format.html { redirect_to skins_url }
      format.json { head :no_content }
    end
  end
end
