class SkinsController < ApplicationController
  load_and_authorize_resource

  def index
    # @skins = Skin.all

    respond_to do |format|
      format.html
    end
  end

  # def show
  #   # @skin = Skin.find(params[:id])

  #   respond_to do |format|
  #     format.html
  #   end
  # end

  def new
    # @skin = Skin.new

    respond_to do |format|
      format.html
    end
  end

  def edit
    # @skin = Skin.find(params[:id])
  end

  def create
    # @skin = Skin.new(params[:skin])

    respond_to do |format|
      if @skin.save
        format.html { redirect_to skins_url, notice: 'Skin was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @skin = Skin.find(params[:id])

    respond_to do |format|
      if @skin.update_attributes(params[:skin])
        format.html { redirect_to skins_url, notice: 'Skin was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @skin = Skin.find(params[:id])
    @skin.destroy

    redirect_to skins_url
  end
end