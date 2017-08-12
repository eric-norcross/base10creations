class TrackersController < ApplicationController
  # GET /trackers/1
  def show
    Tracker.create(remote_ip: request.remote_ip)
    send_data open(view_context.image_url("tracker.gif")), filename: 'tracker.gif', type: 'image/gif'
  end

  private
    # Only allow a trusted parameter "white list" through.
    def tracker_params
      params.require(:tracker).permit(:remote_ip)
    end
end
