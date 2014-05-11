class CarouselsController < ApplicationController
  authorize_resource :page
  authorize_resource :carousel, :through => :page

  # Admin 
  def manage
    @carousels = Carousel.all
     
    respond_to do |format|
      format.html
    end
  end
  
  def index
    @carousels = Carousel.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @carousels }
    end
  end

  GET /carousels/1
  def show
    @carousel = Carousel.find(params[:id])

    render "#{@carousel.skin.template}"
  end

  def new
    @carousel = Carousel.new

    1.times do
      figures = @carousel.figures.build
      figures.images.build
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @carousel }
    end
  end

  def edit
    @carousel = Carousel.find(params[:id])
  end

  def create
    @carousel = Carousel.new(params[:carousel])

    respond_to do |format|
      if @carousel.save
        format.html { redirect_to carousels_url, notice: 'Carousel was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @carousel = Carousel.find(params[:id])

    respond_to do |format|
      if @carousel.update_attributes(params[:carousel])
        format.html { redirect_to carousels_url, notice: 'Carousel was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @carousel = Carousel.find(params[:id])
    @carousel.destroy

    respond_to do |format|
      format.html { redirect_to carousels_url }
    end
  end
end