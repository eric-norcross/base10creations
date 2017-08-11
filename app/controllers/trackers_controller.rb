class TrackersController < ApplicationController
  # GET /trackers/1
  def show
    # data = open("http://www.gravatar.com/avatar/c2713a4959692f16d27d2553fb06cc4b.png?r=x&s=170") 

    # data = open(asset_url("colinparent_@1x.jpg"))
    # send_data data, type: image.content_type, disposition: 'inline'


    # [ 200, { 'Content-Type' => 'image/png' }, [ File.read(File.join(File.dirname(__FILE__), 'track.png')) ] ]
    # send_data image.data, type: image.content_type, disposition: :inline


    # send_data File.read("app/assets/images/", mode: "rb"), filename: 'tracker.gif', type: 'image/gif'

    send_data open(view_context.image_url("tracker.gif")), filename: 'tracker.gif', type: 'image/gif'
  end

  private
    # Only allow a trusted parameter "white list" through.
    def tracker_params
      params.require(:tracker).permit(:domain)
    end
end
