class Manage::FiguresController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_figure, only: [:show, :edit, :update, :destroy]

  # GET /figures
  def index
    @figures = Figure.all
  end

  # GET /figures/1
  def show
  end

  # GET /figures/new
  def new
    @figure = Figure.new
  end

  # GET /figures/1/edit
  def edit
  end

  # POST /figures
  def create
    @figure = Figure.new(figure_params)

    if @figure.save
      redirect_to @figure, notice: 'Figure was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /figures/1
  def update
    if @figure.update(figure_params)
      redirect_to @figure, notice: 'Figure was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /figures/1
  def destroy
    @figure.destroy
    redirect_to figures_url, notice: 'Figure was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_figure
      @figure = Figure.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def figure_params
      params.fetch(:figure, {})
    end
end
