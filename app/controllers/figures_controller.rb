class FiguresController < ApplicationController
  load_and_authorize_resource :page
  load_and_authorize_resource :figure, :through => :page

  # def index
  #   @figures = Figure.all

  #   respond_to do |format|
  #     format.html # index.html.erb
  #     format.json { render json: @figures }
  #   end
  # end

  # def show
  #   @figure = Figure.find(params[:id])

  #   respond_to do |format|
  #     format.html # show.html.erb
  #     # format.json { render json: @style }
  #   end
  # end

  def new
    @figure = Figure.new

    1.times do
      @figure.images.build
    end

    respond_to do |format|
      format.html
    end
  end

  def edit
    @figure = Figure.find(params[:id])
  end

  def create
    @figure = Figure.new(params[:figure])

    respond_to do |format|
      if @figure.save
        format.html { redirect_to @figure, notice: 'Figure was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @figure = Figure.find(params[:id])

    respond_to do |format|
      if @figure.update_attributes(params[:figure])
        format.html { redirect_to figures_url, notice: 'Figure was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @figure = Figure.find(params[:id])
    @figure.destroy

    respond_to do |format|
      format.html { redirect_to figures_url }
    end
  end
end