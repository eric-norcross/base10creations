class FinishesController < ApplicationController
  load_and_authorize_resource

  # Ajax Routes
  def skus
    @skus = Finish.skus(params[:id])
    render "skus/_list", locals: { type: params[:type] }, layout: false
  end

  # REST Routes
  def index
    # @finishes = Finish.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @finishes }
    end
  end

  def show
    @side_nav_elements = Finish.all
    
    @products = Finish.products_and_compilations(params[:id])

    render "layouts/templates/list"
  end

  def new
    # @finish = Finish.new

    @finish.image.build

    respond_to do |format|
      format.html
    end
  end

  def edit
    # @finish = Finish.find(params[:id])
  end

  def create
    # @finish = Finish.new(params[:finish])

    respond_to do |format|
      if @finish.save
        format.html { redirect_to finishes_path, notice: 'Finish was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    # @finish = Finish.find(params[:id])

    respond_to do |format|
      if @finish.update_attributes(params[:finish])
        format.html { redirect_to finishes_url, notice: 'Finish was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    # @finish = Finish.find(params[:id])
    @finish.destroy

    redirect_to finishes_url
  end
end