class SubcomponentsController < ApplicationController
  def retrieve_subcomponents
    @components = Component.find(params[:id])
    @subcomponents = @components.subcomponents

    render "subcomponents/_select", layout: false
  end
end
