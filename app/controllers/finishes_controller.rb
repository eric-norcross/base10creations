class FinishesController < ApplicationController
  def index
    @finishes = Finish.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @finishes }
    end
  end

  # GET /finishes/1
  def show
    @finish = Finish.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      # format.json { render json: @style }
    end
  end

  # GET /finishes/new
  # GET /finishes/new.json
  def new
    @finish = Finish.new

    @finish.image.build

    # @finish.build_image

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @finish }
    end
  end

  # GET /finishes/1/edit
  def edit
    @finish = Finish.find(params[:id])
  end

  # POST /finishes
  # POST /finishes.json
  def create
    @finish = Finish.new(params[:finish])

    respond_to do |format|
      if @finish.save
        format.html { redirect_to @finish, notice: 'Finish was successfully created.' }
        format.json { render json: finishes_url, status: :created, location: @finish }
      else
        format.html { render action: "new" }
        format.json { render json: @finish.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /finishes/1
  # PUT /finishes/1.json
  def update
    @finish = Finish.find(params[:id])

    respond_to do |format|
      if @finish.update_attributes(params[:finish])
        format.html { redirect_to finishes_url, notice: 'Finish was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @finish.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /finishes/1
  # DELETE /finishes/1.json
  def destroy
    @finish = Finish.find(params[:id])
    @finish.destroy

    respond_to do |format|
      format.html { redirect_to finishes_url }
      format.json { head :no_content }
    end
  end
end