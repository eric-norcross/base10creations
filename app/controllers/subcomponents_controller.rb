class SubcomponentsController < ApplicationController
  def retrieve_subcomponents
    @components = Component.find(params[:id])
    @subcomponents = @components.subcomponents

    render "subcomponents/_select", locals: { type: params[:type] }, layout: false

  end
end
