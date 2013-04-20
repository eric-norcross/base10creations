class FinishesController < ApplicationController
def index
    @finishes = Finish.all

    respond_to do |format|
      format.html # index.html.erb
      # format.json { render json: @finishes }
    end
  end

  # def show
  #   @finish = Finish.find(params[:id])

  #   respond_to do |format|
  #     format.html # show.html.erb
  #     # format.json { render json: @finish }
  #   end
  # end

  def new
    @finish = Finish.new

    respond_to do |format|
      format.html # new.html.erb
      # format.json { render json: @finish }
    end
  end

  def edit
    @finish = Finish.find(params[:id])
  end

  def create
    @finish = Finish.new(params[:finish])

    respond_to do |format|
      if @finish.save
        format.html { redirect_to finishes_url, notice: 'Finish was successfully created.' }
        # format.json { render json: @finish, status: :created, location: @finish }
      else
        format.html { render action: "new" }
        # format.json { render json: @finish.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @finish = Finish.find(params[:id])

    respond_to do |format|
      if @finish.update_attributes(params[:finish])
        format.html { redirect_to finishes_url, notice: 'Finish was successfully updated.' }
        # format.json { head :no_content }
      else
        format.html { render action: "edit" }
        # format.json { render json: @finish.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @finish = Finish.find(params[:id])
    @finish.destroy

    respond_to do |format|
      format.html { redirect_to finishes_url }
      # format.json { head :no_content }
    end
  end
end