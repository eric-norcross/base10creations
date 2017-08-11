class Manage::TrackersController < ApplicationController
  before_action :set_tracker, only: [:show, :edit, :update, :destroy]

  # GET /trackers
  def index
    @trackers = Tracker.all
  end

  # GET /trackers/1
  def show
  end

  # GET /trackers/new
  def new
    @tracker = Tracker.new
  end

  # GET /trackers/1/edit
  def edit
  end

  # POST /trackers
  def create
    @tracker = Tracker.new(tracker_params)

    if @tracker.save
      redirect_to @tracker, notice: 'Tracker was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /trackers/1
  def update
    if @tracker.update(tracker_params)
      redirect_to @tracker, notice: 'Tracker was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /trackers/1
  def destroy
    @tracker.destroy
    redirect_to trackers_url, notice: 'Tracker was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tracker
      @tracker = Tracker.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def tracker_params
      params.require(:tracker).permit(:domain)
    end
end
