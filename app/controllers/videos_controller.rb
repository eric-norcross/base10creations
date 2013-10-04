class VideosController < ApplicationController
  load_and_authorize_resource

  # Admin Routes
  def manage
    respond_to do |format|
      format.html
    end
  end


  # REST Routes
  # def index
  #   respond_to do |format|
  #     format.html
  #   end
  # end

  # def show
  #   respond_to do |format|
  #     format.html
  #   end
  # end

  # def new
  #   respond_to do |format|
  #     format.html
  #   end
  # end

  def edit
    # @video = Video.find(params[:id])
  end

  def create
    # @video = Video.new(params[:video])

    respond_to do |format|
      if @video.save
        format.html { redirect_to @video, notice: 'Video was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    # @video = Video.find(params[:id])

    respond_to do |format|
      if @video.update_attributes(params[:video])
        format.html { redirect_to videos_url, notice: 'Video was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    # @video = Video.find(params[:id])
    @video.destroy

    respond_to do |format|
      format.html { redirect_to videos_url }
      format.json { head :no_content }
    end
  end
end