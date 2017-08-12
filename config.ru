# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'
require 'rack/rewrite'
use Rack::Rewrite do
  r301 '/assets/tracker-b1442e85b03bdcaf66dc58c7abb98745dd2687d86350be9a298a1d9382ac849b.gif', '/trackers/1'
end
run Rails.application
